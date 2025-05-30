from flask import Flask, request, redirect, jsonify, render_template, session
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash
import os
import pyodbc
from datetime import datetime
from functools import wraps

app = Flask(__name__)
CORS(app)
app.secret_key = 'your-secret-key'  # Needed for session management

# --- Database Connection Setup ---
conn_str = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=AYESHA;'
    'DATABASE=final_project;'
    'Trusted_Connection=yes;'
)

def get_db_connection():
    return pyodbc.connect(conn_str)

# --- Admin Login System ---
@app.route('/api/admin/login', methods=['POST', 'GET'])
def admin_login():
    if request.method == 'POST':
        email = request.form.get('email')  # ✅ Changed
        pwd = request.form.get('password')  # ✅ Changed

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT admin_id, password_hash FROM admins WHERE email = ?", (email,))
        row = cur.fetchone()
        cur.close()
        conn.close()

        if row and check_password_hash(row[1], pwd):
            session['admin_id'] = row[0]
            return redirect('/admin')  # ✅ Redirect to admin panel
        else:
            return "Invalid credentials", 401

    return render_template('login.html')  # ✅ Show login form for GET requests


@app.route('/api/admin/logout', methods=['POST'])
def admin_logout():
    session.pop('admin_id', None)
    return jsonify({'message':'Logged out'}), 200

def require_admin(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if 'admin_id' not in session:
            return jsonify({'error':'Admin login required'}), 403
        return fn(*args, **kwargs)
    return wrapper

# --- Search Products by Name, Brand, or Category ---
@app.route('/api/products', methods=['GET'])
def search_products():
    name = request.args.get('name', '')
    brand = request.args.get('brand', '')
    category = request.args.get('category', '')

    conn = get_db_connection(); cursor = conn.cursor()

    query = """
        SELECT p.product_id, p.product_name, b.brand_name, b.affiliation_status, c.category_name
        FROM products p
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN categories c ON p.category_id = c.category_id
        WHERE 1=1
    """
    params = []

    if name:
        query += " AND p.product_name LIKE ?"
        params.append(f"%{name}%")
    if brand:
        query += " AND b.brand_name LIKE ?"
        params.append(f"%{brand}%")
    if category:
        query += " AND c.category_name LIKE ?"
        params.append(f"%{category}%")

    cursor.execute(query, params)
    results = cursor.fetchall()
    columns = [col[0] for col in cursor.description]
    data = [dict(zip(columns, row)) for row in results]

    cursor.close(); conn.close()
    return jsonify(data)

# --- Get Products by Category ID ---
@app.route('/api/categories/<int:category_id>/products', methods=['GET'])
def get_products_by_category(category_id):
    conn = get_db_connection(); cursor = conn.cursor()
    cursor.execute("""
        SELECT p.product_id, p.product_name, b.brand_name, b.affiliation_status, c.category_name
        FROM products p
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.category_id = ?
    """, (category_id,))
    rows = cursor.fetchall()

    boycotted = []
    alternatives = []

    for row in rows:
        product = {
            'product_id': row[0],
            'product_name': row[1],
            'brand_name': row[2],
            'affiliation_status': row[3],
            'category_name': row[4]
        }
        if product['affiliation_status'].lower() == 'israeli':
            boycotted.append(product)
        else:
            alternatives.append(product)

    cursor.close(); conn.close()
    return jsonify({'boycotted': boycotted, 'alternatives': alternatives})

# --- Submit Suggestion (user suggests update or delete) ---
@app.route('/api/suggestions', methods=['POST'])
def add_suggestion():
    data = request.json
    conn = get_db_connection()
    cur = conn.cursor()

    # Extract required fields from request JSON
    suggestion_type = data.get('suggestion_type')
    target_product_name = data.get('target_product_name')
    target_brand_name = data.get('target_brand_name')
    target_category_name = data.get('target_category_name')
    suggested_product_name = data.get('suggested_product_name') if suggestion_type == 'update' else None
    reason = data.get('reason')

    if not suggestion_type or not target_product_name or not target_brand_name or not target_category_name or not reason:
        cur.close()
        conn.close()
        return jsonify({'error': 'Missing required fields'}), 400

    # Insert new suggestion record
    cur.execute("""
        INSERT INTO suggestions (
            target_product_name,
            target_brand_name,
            target_category_name,
            suggested_product_name,
            reason,
            suggestion_type,
            status,
            admin_comment
        ) VALUES (?, ?, ?, ?, ?, ?, 'pending', NULL)
    """, (
        target_product_name,
        target_brand_name,
        target_category_name,
        suggested_product_name,
        reason,
        suggestion_type
    ))

    conn.commit()
    cur.close()
    conn.close()

    return jsonify({'message': 'Suggestion submitted successfully'}), 201



# extra
@app.route("/api/categories")
def get_categories():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT DISTINCT category_name FROM categories WHERE category_name IS NOT NULL")
    categories = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return jsonify(categories)

@app.route("/api/brands")
def get_brands():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT DISTINCT brand_name FROM brands WHERE brand_name IS NOT NULL")
    brands = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return jsonify(brands)

# --- Admin Approves Suggestion (and updates products table) ---
@app.route('/api/admin/suggestions/<int:idx>/approve', methods=['POST'])
@require_admin
def approve_suggestion(idx):
    admin_id = session['admin_id']
    now = datetime.utcnow()
    conn = get_db_connection()
    cur = conn.cursor()

    # Get suggestion details (no target_product_id in suggestions!)
    cur.execute("SELECT suggestion_type, target_product_name, target_brand_name, target_category_name, suggested_product_name FROM suggestions WHERE suggestion_id = ?", (idx,))
    row = cur.fetchone()
    if not row:
        return jsonify({'error': 'Suggestion not found'}), 404

    s_type, target_product_name, target_brand_name, target_category_name, new_name = row

    # Find product_id based on target product details
    cur.execute("""
        SELECT p.product_id
        FROM products p
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.product_name = ? AND b.brand_name = ? AND c.category_name = ?
    """, (target_product_name, target_brand_name, target_category_name))
    prod_row = cur.fetchone()

    if not prod_row:
        return jsonify({'error': 'Target product not found'}), 404

    product_id = prod_row[0]

    if s_type == 'update' and new_name:
     cur.execute("UPDATE products SET product_name = ? WHERE product_id = ?", (new_name, product_id))
    elif s_type == 'delete':
     cur.execute("DELETE FROM products WHERE product_id = ?", (product_id,))


    # Mark suggestion as approved
    cur.execute("""
        UPDATE suggestions SET status = 'approved', approved_by_admin_id = ?, approval_date = ?
        WHERE suggestion_id = ?
    """, (admin_id, now, idx))

    conn.commit()
    cur.close()
    conn.close()
    return jsonify({'message': 'Suggestion approved and product updated'}), 200


# --- Admin Rejects Suggestion ---
@app.route('/api/admin/suggestions/<int:idx>/reject', methods=['POST'])
@require_admin
def reject_suggestion(idx):
    admin_id = session['admin_id']
    now = datetime.utcnow()
    conn = get_db_connection(); cur = conn.cursor()

    cur.execute("""
        UPDATE suggestions SET approval_status = 'rejected', approved_by_admin_id = ?, approval_date = ?
        WHERE suggestion_id = ?
    """, (admin_id, now, idx))

    conn.commit(); cur.close(); conn.close()
    return jsonify({'message': 'Suggestion rejected'}), 200

# --- Delete Suggestion (Admin only) ---
@app.route('/api/admin/suggestions/<int:idx>', methods=['DELETE'])
@require_admin
def delete_suggestion(idx):
    conn = get_db_connection(); cur = conn.cursor()
    cur.execute("DELETE FROM suggestions WHERE suggestion_id = ?", (idx,))
    conn.commit(); cur.close(); conn.close()
    return jsonify({'message': 'Suggestion deleted'}), 200

@app.route('/api/product/details')
def get_product_details():
    product_name = request.args.get('product_name')
    if not product_name:
        return jsonify({'error': 'Missing product_name parameter'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT b.brand_name, c.category_name 
        FROM products p
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.product_name = ?
    """, (product_name,))
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if row:
        return jsonify({'brand_name': row[0], 'category_name': row[1]})
    else:
        return jsonify({'error': 'Product not found'}), 404


@app.route('/')
def splash():
    return render_template('splash.html')

# Login page
@app.route('/login')
def login():
    return render_template('login.html')

# Search page
@app.route('/search')
def search():
    return render_template('search.html')

# Admin panel page
@app.route('/admin')
@require_admin
def admin_panel():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM suggestions")
    rows = cur.fetchall()
    columns = [col[0] for col in cur.description]
    suggestions = [dict(zip(columns, row)) for row in rows]
    cur.close()
    conn.close()
    return render_template('adminpanel.html', suggestions=suggestions)


#for categories in the dropdown
@app.route('/category/<category_name>')
def category_page(category_name):
    template_path = f'categories/{category_name.lower()}.html'
    
    # Check if template exists before rendering
    if os.path.exists(os.path.join(app.template_folder, template_path)):
        return render_template(template_path)
    else:
        abort(404)



@app.route('/api/products/list', methods=['GET'])
def get_all_products():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT product_name FROM products")
    products = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return jsonify(products)

    #mapping category name to id
@app.route('/api/category-id')
def get_category_id():
    name = request.args.get('name')
    if not name:
        return jsonify({'error': 'Missing category name'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT category_id FROM categories WHERE LOWER(category_name) = LOWER(?)", (name,))
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if row:
        return jsonify({'id': row[0]})
    else:
        return jsonify({'error': 'Not found'}), 404

@app.route('/api/admin/products', methods=['POST'])
@require_admin
def add_product():
    data = request.json
    product_name = data.get('product_name')
    brand_name = data.get('brand_name')
    category_name = data.get('category_name')
    affiliation_status = data.get('affiliation_status')

    if not all([product_name, brand_name, category_name, affiliation_status]):
        return jsonify({'error': 'Missing required fields'}), 400

    conn = get_db_connection()
    cur = conn.cursor()

    # Get or insert brand
    cur.execute("SELECT brand_id FROM brands WHERE brand_name = ?", (brand_name,))
    brand_row = cur.fetchone()
    if not brand_row:
        cur.execute("INSERT INTO brands (brand_name, affiliation_status) VALUES (?, ?)", (brand_name, affiliation_status))
        conn.commit()
        cur.execute("SELECT brand_id FROM brands WHERE brand_name = ?", (brand_name,))
        brand_row = cur.fetchone()
    brand_id = brand_row[0]

    # Get or insert category
    cur.execute("SELECT category_id FROM categories WHERE category_name = ?", (category_name,))
    cat_row = cur.fetchone()
    if not cat_row:
        cur.execute("INSERT INTO categories (category_name) VALUES (?)", (category_name,))
        conn.commit()
        cur.execute("SELECT category_id FROM categories WHERE category_name = ?", (category_name,))
        cat_row = cur.fetchone()
    category_id = cat_row[0]

    # Insert product
    cur.execute("INSERT INTO products (product_name, brand_id, category_id) VALUES (?, ?, ?)",
                (product_name, brand_id, category_id))

    conn.commit()
    cur.close()
    conn.close()
    return jsonify({'message': 'Product added successfully'}), 201

# --- Start server ---
if __name__ == '__main__':
    app.run(debug=True)
