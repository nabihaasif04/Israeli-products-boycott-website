# Boycott-Detector Web Application

A full-stack web application that helps users identify and avoid products based on geopolitical affiliations, with admin moderation capabilities.

## Table of Contents
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Database Schema](#database-schema)
- [API Documentation](#api-documentation)
- [Project Structure](#project-structure)

## Features

### User Features
- 🔍 Search products by name, brand, or category
- 🏷 View brand affiliation status (Israeli/Local/Neutral)
- 📝 Submit suggestions to update or delete products
- 📊 Browse products by category
- 🔎 View product details

### Admin Features
- 🔒 Secure admin login system
- ✅ Approve/reject user suggestions
- ✏️ Add admin comments to suggestions
- 🗑️ Delete suggestions
- ➕ Add new products directly

## Technology Stack

### Frontend
- HTML5 with semantic markup
- CSS3 with responsive design
- Minimal JavaScript for basic interactions
- Jinja2 templating for dynamic content

### Backend
- Python 3.x
- Flask web framework
- Flask-CORS for cross-origin support
- Werkzeug for security and authentication

### Database
- SQL Server (via pyodbc)
- Normalized relational schema
- Stored procedures (if applicable)

### Deployment
- Can be deployed with WSGI (like Gunicorn)
- Nginx reverse proxy (production)
- Docker compatible

## Installation

### Prerequisites
- Python 3.7+
- SQL Server
- ODBC Driver 17 for SQL Server
- pip package manager

### Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Boycott-Detector-Website.git
cd Boycott-Detector-Website
```

2. Create and activate virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install flask flask-cors pyodbc werkzeug
```

4. Database setup:
- Create database `final_project` on your SQL Server
- Execute the SQL scripts to create tables (see database/schema.sql)

5. Configure the application:
```bash
cp config.example.py config.py
# Edit config.py with your database credentials
```

6. Run the application:
```bash
python app.py
```

Access the application at `http://localhost:5000`

## Database Schema

### Core Tables
- **products** - Product information
- **brands** - Brand details and affiliation status
- **categories** - Product classification
- **suggestions** - User submissions for changes
- **admins** - Admin user accounts

### Relationships
- Products belong to Brands (many-to-one)
- Products belong to Categories (many-to-one)
- Suggestions reference Products (many-to-one)
- Suggestions are processed by Admins (many-to-one)

## API Documentation

### Public Endpoints
- `GET /api/products` - Search products
- `GET /api/categories` - List all categories
- `GET /api/brands` - List all brands
- `POST /api/suggestions` - Submit a suggestion

### Admin Endpoints (require authentication)
- `POST /api/admin/login` - Admin login
- `POST /api/admin/logout` - Admin logout
- `POST /api/admin/suggestions/<id>/approve` - Approve suggestion
- `POST /api/admin/suggestions/<id>/reject` - Reject suggestion
- `DELETE /api/admin/suggestions/<id>` - Delete suggestion
- `POST /api/admin/products` - Add new product

## Project Structure

```
boycott-detector/
├── app.py                # Main Flask application
├── config.py             # Configuration file
├── requirements.txt      # Python dependencies
├── static/               # Static files (CSS, JS, images)
│   ├── css/
│   └── images/
├── templates/            # HTML templates
│   ├── adminpanel.html   # Admin interface
│   ├── search.html       # Search page
│   ├── login.html        # Login page
│   └── splash.html       # Home page
└── database/
    ├── setup.sql         # Database schema
    └── sample_data.sql   # Sample data
```

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please ensure your code follows PEP 8 guidelines and includes appropriate tests.

**Note**: This application is developed for educational purposes. The maintainers do not endorse any particular political view. All data should be independently verified.
