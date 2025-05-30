CREATE DATABASE final_project;
USE final_project

CREATE TABLE brands(
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    affiliation_status VARCHAR(50) NOT NULL CHECK (affiliation_status IN ('Israeli', 'Local'))
);

CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL
);
CREATE TABLE suggestions (
    suggestion_id INT PRIMARY KEY IDENTITY(1,1),

    target_product_name VARCHAR(100),
    target_brand_name VARCHAR(100),
    target_category_name VARCHAR(100),

    suggested_product_name VARCHAR(100),  -- optional for update
    reason TEXT,
    suggestion_type VARCHAR(20),          -- 'update' or 'delete'
    status VARCHAR(20) DEFAULT 'pending',
    admin_comment TEXT
);

ALTER TABLE suggestions
ADD approved_by_admin_id INT NULL,
    approval_date DATETIME NULL,
    CONSTRAINT FK_ApprovedByAdmin FOREIGN KEY (approved_by_admin_id) REFERENCES admins(admin_id);

CREATE TABLE admins (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    login_id VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

INSERT INTO admins (login_id, email, password_hash) 
VALUES ('ayesha', 'ayesha@email.com', 'scrypt:32768:8:1$7hXCpfVYGuPb6bhk$42af1532696f9279506206063305834841a0d3df6ad70841a6662222efe5bcd52a11f9bd3589294bba3789daa8e91c075f2db5d2fac8bf487a7651c34d726b03');

SELECT * FROM products;
SELECT * FROM brands;

SELECT * FROM suggestions ORDER BY suggestion_id DESC;
SELECT * FROM products WHERE product_name = 'McDonalds BigMac';


INSERT INTO categories (category_id, category_name) VALUES
(1, 'Restaurants'),
(2, 'Cosmetics'),
(3, 'Cold Drinks'),
(4, 'Chocolates & Spreads'),
(5, 'Icecream'),
(6, 'Tea & Coffee'),
(7, 'Juices'),
(8, 'Flavoured Drinks'),
(9, 'Dairy Products'),
(10, 'Water'),
(11, 'Cereals'),
(12, 'Snacks'),
(13, 'Biscuits'),
(14, 'Noodles & Pasta'),
(15, 'Iced Tea'),
(16, 'Shampoos'),
(17, 'Toothpaste'),
(18, 'Body Care'),
(19, 'Sanitary Napkins'),
(20, 'Babycare'),
(21, 'Detergents');

INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (1, 'KFC', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (2, 'McDonalds', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (3, 'Hardees', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (4, 'PizzaHut', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (5, 'Subway', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (6, 'Burger King', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (7, 'Baskin & Robbins', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (8, 'Burger Lab', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (9, 'Johnny and Jugnu', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (10, 'Smash Burger', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (11, 'Howdy', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (12, 'BRGR', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (13, 'Sweet Creme', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (14, 'Daily Deli', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (15, 'OPTP', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (16, 'Loréal', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (17, 'Revlon', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (18, 'Garnier', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (19, 'Estee Lauder', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (20, 'Olay', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (21, 'J.', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (22, 'Luscious Cosmetics', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (23, 'Musarrat Misbah', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (24, 'Rivaj', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (25, 'Coca Cola', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (26, '7-UP', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (27, 'Fanta', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (28, 'Pepsi', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (29, 'Sprite', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (30, 'Mirinda', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (31, 'Mountain Dew', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (32, 'Roar', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (33, 'Cappy', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (34, 'Gourmet', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (35, 'Pakola', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (36, 'Next', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (37, 'Youngs', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (38, 'Candyland', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (39, 'You', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (40, 'Walls', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (41, 'HICO', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (42, 'Lush Crush', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (43, 'Popbar', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (44, 'Popcycle', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (45, 'Jalal Sons', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (46, 'Kitchen Cuisine', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (47, 'Lipton', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (48, 'Nestle', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (49, 'Nescafe', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (50, 'Vital', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (51, 'National', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (52, 'ITC', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (53, 'Tapal', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (54, 'RAAZ', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (55, 'Fresher', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (56, 'Fruitien', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (57, 'Maza', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (58, 'Vivo', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (59, 'Sunsip', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (60, 'Rooh Afza', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (61, 'Jaam e Shireen', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (62, 'Milo', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (63, 'Nesquik', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (64, 'Dayfresh', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (65, 'Shakarganj', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (66, 'Prema', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (67, 'Anhaar', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (68, 'Haleeb', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (69, 'Good Milk', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (70, 'Nurpur', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (71, 'Tarang', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (72, 'Prema Yogurt', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (73, 'Adams', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (74, 'Aquafina', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (75, 'Dasani', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (76, 'Sufi', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (77, 'Masafi', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (78, 'Springley', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (79, 'Al Habib', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (80, 'al-kafeel of hasan industries', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (81, 'Nestle CocoCrunch', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (82, 'Kelloggs', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (83, 'Nutri Lov', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (84, 'Fauji', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (85, 'Lays', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (86, 'Cheetos', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (87, 'Kurkure', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (88, 'Pringles', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (89, 'Doritos', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (90, 'Munchies', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (91, 'Super Crisp', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (92, 'Oye Hoye', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (93, 'Kurleez', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (94, 'Knock Out', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (95, 'Kolson Snacks', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (96, 'LU', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (97, 'Bisconni', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (98, 'Whistlez', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (99, 'Innovative', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (100, 'EBM', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (101, 'Maggi', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (102, 'Knorr', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (103, 'Kolson', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (104, 'Shan', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (105, 'Nestea', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (106, 'Fuzetea', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (107, 'Tapal Ice Tea', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (108, 'Dove', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (109, 'Sunsilk', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (110, 'Pantene', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (111, 'Head & Shoulders', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (112, 'Clear', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (113, 'Tresemme', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (114, 'CoNatural', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (115, 'BioAmla', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (116, 'Colgate', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (117, 'Sensodyne', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (118, 'Medicam', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (119, 'Dentonic', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (120, 'Jasmine Organics ', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (121, 'Lux', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (122, 'Lifebuoy', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (123, 'Ponds', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (124, 'Fair & Glow', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (125, 'Gilette', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (126, 'Veet', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (127, 'Care', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (128, 'Nisa', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (129, 'Hiba''s Collection', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (130, 'Treet', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (131, 'Saeed Ghani', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (132, 'Always', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (133, 'Butterfly', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (134, 'Mother Comfort', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (135, 'Trust', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (136, 'Johnsons', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (137, 'Pampers', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (138, 'Huggies', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (139, 'Sheild Babycare', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (140, 'Leo', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (141, 'Surf Excel', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (142, 'Ariel', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (143, 'Bonus', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (144, 'Bright', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (145, 'Express', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (146, 'Vim', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (147, 'Max', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (148, 'Sunlight', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (149, 'Alclean', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (150, 'Almas', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (151, 'Nutella', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (152, 'Kitkat', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (153, 'Mars', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (154, 'Twix', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (155, 'Snickers', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (156, 'Toblerone', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (157, 'Hersheys', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (158, 'Milka', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (159, 'Ferrero Rocher', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (160, 'Beuno', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (161, 'Cadbury', 'Israeli');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (162, 'Youngs Chocolate Spread', 'Local');
INSERT INTO brands (brand_id, brand_name, affiliation_status) VALUES (163, 'Candyland', 'Local');


SELECT * FROM brands;

DELETE FROM brands
WHERE brand_name = 'Youngs Chocolate Spread';

INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (1, 'KFC', 1, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (2, 'McDonalds', 2, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (3, 'Hardees', 3, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (4, 'PizzaHut', 4, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (5, 'Subway', 5, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (6, 'Burger King', 6, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (7, 'Baskin & Robbins', 7, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (8, 'Burger Lab', 8, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (9, 'Johnny and Jugnu', 9, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (10, 'Smash Burger', 10, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (11, 'Howdy', 11, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (12, 'BRGR', 12, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (13, 'Sweet Creme', 13, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (14, 'Daily Deli', 14, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (15, 'OPTP', 15, 1);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (16, 'Loréal Cosmetic', 16, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (17, 'Revlon Cosmetic', 17, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (18, 'Garnier Cosmetic', 18, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (19, 'Estee Lauder Cosmetic', 19, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (20, 'Olay Cosmetic', 20, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (21, 'J. Cosmetic', 21, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (22, 'Luscious Cosmetics', 22, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (23, 'Musarrat Misbah Cosmetics', 23, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (24, 'Rivaj Cosmetic', 24, 2);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (25, 'Coca Cola Cold Drink', 25, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (26, '7-UP Cold Drink', 26, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (27, 'Fanta Cold Drink', 27, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (28, 'Pepsi Cold Drink', 28, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (29, 'Sprite Cold Drink', 29, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (30, 'Mirinda Cold Drink', 30, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (31, 'Mountain Dew Cold Drink', 31, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (32, 'Roar Cold Drink', 32, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (33, 'Cappy Soft Drink', 33, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (34, 'Gourmet Cola Cold Drink', 34, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (35, 'Gourmet Lemon Up Cold Drink', 34, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (36, 'Pakola Cold Drink', 35, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (37, 'Next Cola', 36, 3);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (38, 'Nutella Spread', 151, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (39, 'Kitkat Chocolate', 152, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (40, 'Mars Chocolate', 153, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (41, 'Twix Chocolate', 154, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (42, 'Snickers Chocolate', 155, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (43, 'Toblerone Chocolate', 156, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (44, 'Hersheys Chocolate', 157, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (45, 'Milka Chocolate', 158, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (46, 'Ferrero Rocher Chocolate', 159, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (47, 'Beuno Chocolate', 160, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (48, 'Cadbury Chocolate', 161, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (49, 'Youngs Chocolate Spread', 37, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (50, 'Candyland Now', 163, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (51, 'Candyland Paradise', 163, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (52, 'Candyland Sonnet', 163, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (53, 'Candyland Novella', 163, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (54, 'You Chocolate', 39, 4);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (55, 'Walls Icecream', 40, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (56, 'HICO Icecream', 41, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (57, 'Lush Crush Icecream', 42, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (58, 'Popbar Icecream', 43, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (59, 'Popcycle Icecream', 44, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (60, 'Jalal Sons Icecream', 45, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (61, 'Kitchen Cuisine Icecream', 46, 5);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (63, 'Lipton Tea', 47, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (64, 'Nestle Everyday Tea', 48, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (65, 'Nescafe Coffee', 49, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (66, 'Vital Tea', 50, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (67, 'National Tea', 51, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (68, 'ITC', 52, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (69, 'Tapal Tea', 53, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (70, 'RAAZ Coffee Roasters', 54, 6);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (71, 'Nestle Fruita Vitals Juice', 48, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (72, 'Nestle Nesfruita Juice', 48, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (73, 'Fresher Juice', 55, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (74, 'Fruitien Juice', 56, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (75, 'Maza Juice', 57, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (76, 'Vivo Juice', 58, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (77, 'Sunsip LimoPani', 59, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (78, 'Rooh Afza', 60, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (79, 'Jami Shireen', 61, 7);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (80, 'Milo ', 62, 8);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (81, 'Nesquik Flavoured Drink', 63, 8);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (82, 'Dayfresh Flavoured Drink', 64, 8);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (83, 'Shakarganj Flavoured Drink', 65, 8);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (84, 'Pakola Flavoured Drink', 35, 8);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (85, 'Nestle Milkpak', 48, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (86, 'Nestle Everyday', 48, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (87, 'Nestle Yogurt', 48, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (88, 'Nesvita', 48, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (89, 'Prema Milk', 66, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (90, 'Anhaar Milk', 67, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (91, 'Dayfresh Milk', 64, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (92, 'Haleeb Milk', 68, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (93, 'Good Milk', 69, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (94, 'Adams Milk', 73, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (95, 'Nurpur Milk', 70, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (96, 'Tarang Milk', 71, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (97, 'Prema Yogurt', 66, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (98, 'Gourmet Yogurt', 34, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (99, 'Adams Cheese', 73, 9);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (100, 'Nestle', 48, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (101, 'Aquafina', 74, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (102, 'Dasani', 75, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (103, 'Gourmet', 34, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (104, 'Sufi', 76, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (105, 'Pakola', 35, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (106, 'Masafi', 77, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (107, 'Springley', 78, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (108, 'Al Habib', 79, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (109, 'al-kafeel of hasan industries', 80, 10);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (110, 'Nestle CocoCrunch Cereal', 81, 11);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (111, 'Kelloggs Cereal', 82, 11);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (112, 'Nutri Lov Crunchy Cereal', 83, 11);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (113, 'Fauji Cornflakes', 84, 11);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (114, 'Lays', 85, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (115, 'Cheetos', 86, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (116, 'Kurkure', 87, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (117, 'Pringles', 88, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (118, 'Doritos', 89, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (119, 'Munchies', 90, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (120, 'Super Crisp', 91, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (121, 'Oye Hoye', 92, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (122, 'Kurleez', 93, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (123, 'Knock Out', 94, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (124, 'Kolson Snacks', 95, 12);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (125, 'LU Biscuit', 96, 13);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (126, 'Bisconni Biscuit', 97, 13);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (127, 'Whistlez Biscuit', 98, 13);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (128, 'Innovative Biscuit', 99, 13);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (129, 'EBM (English Biscuit Manufacturer)', 100, 13);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (130, 'Maggi Noodles', 101, 14);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (131, 'Knorr Noodles', 102, 14);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (132, 'Kolson Pasta', 103, 14);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (133, 'National Pasta', 51, 14);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (134, 'Shoop by Shan', 104, 14);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (135, 'Nestea  Iced Tea', 105, 15);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (136, 'Fuzetea  Iced Tea', 106, 15);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (137, 'Tapal Ice Tea', 107, 15);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (138, 'Dove Shampoo', 108, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (139, 'Sunsilk Shampoo', 109, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (140, 'Pantene Shampoo', 110, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (141, 'Head & Shoulders Shampoo', 111, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (142, 'Clear Shampoo', 112, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (143, 'Tresemme Shampoo', 113, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (144, 'Saeed Ghani Shampoo', 131, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (145, 'CoNatural Shampoo', 114, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (146, 'BioAmla Shampoo', 115, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (147, 'Jasmine Organics Shampoo', 120, 16);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (148, 'Colgate Toothpaste', 116, 17);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (149, 'Sensodyne Toothpaste', 117, 17);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (150, 'Medicam Toothpaste', 118, 17);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (151, 'Dentonic Toothpaste', 119, 17);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (152, 'Jasmine Organics Herbal tooth powder', 120, 17);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (153, 'Lux Body Care', 121, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (154, 'Dove Body Care', 108, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (155, 'Lifebuoy Body Care', 122, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (156, 'Ponds Body Care', 123, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (157, 'Fair & Glow Body Care', 124, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (158, 'Gilette Body Care', 125, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (159, 'Veet Body Care', 126, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (160, 'Care Body Care', 127, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (161, 'Vital Body Care', 50, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (162, 'Nisa Hair Removal Cream', 128, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (163, 'Hiba Hair Removal', 129, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (164, 'Treet Body Care', 130, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (165, 'Saeed Ghani Lotion', 131, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (166, 'Jasmine Organics moisturiser', 120, 18);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (167, 'Always Sanitary Napkins', 132, 19);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (168, 'Butterfly Sanitary Napkins', 133, 19);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (169, 'Mother Comfort Sanitary Napkins', 134, 19);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (170, 'Trust Sanitary Napkins', 135, 19);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (171, 'Johnsons Babycare', 136, 20);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (172, 'Pampers Babycare', 137, 20);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (173, 'Huggies Babycare', 138, 20);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (174, 'Sheild Babycare', 139, 20);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (175, 'Leo Diapers', 140, 20);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (176, 'Surf Excel Detergent', 141, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (177, 'Ariel Detergent', 142, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (178, 'Bonus Detergent', 143, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (179, 'Bright Detergentr', 144, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (180, 'Express Detergent', 145, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (181, 'Vim Dishwashing Detergent', 146, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (182, 'Max Dishwashing Detergent', 147, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (183, 'Sunlight Detergent', 148, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (184, 'Sufi Detergent', 76, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (185, 'Sufi Liquid Dishsoap', 76, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (186, 'Alclean all purpose cleaner', 149, 21);
INSERT INTO products (product_id, product_name, brand_id, category_id) VALUES (187, 'Almas dishwasher', 150, 21);

SELECT * FROM products;

SELECT * FROM categories;

 SELECT p.product_id, p.product_name, b.brand_name, b.affiliation_status, c.category_name
        FROM products p
        JOIN brands b ON p.brand_id = b.brand_id
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.category_id = 3

SELECT suggestion_type, target_product_name, target_brand_name, target_category_name, suggested_product_name FROM suggestions WHERE suggestion_id = 1