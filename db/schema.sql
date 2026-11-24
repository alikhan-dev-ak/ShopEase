CREATE DATABASE IF NOT EXISTS online_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE online_shop;
CREATE TABLE users(
 id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(150) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,phone VARCHAR(30),address TEXT,
 role ENUM('customer','admin') DEFAULT 'customer',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE categories(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(80) UNIQUE NOT NULL);
CREATE TABLE products(
 id INT AUTO_INCREMENT PRIMARY KEY,category_id INT NULL,name VARCHAR(150) NOT NULL,description TEXT,
 price DECIMAL(10,2) NOT NULL,stock_quantity INT NOT NULL DEFAULT 0,image_url VARCHAR(500),
 is_active BOOLEAN DEFAULT TRUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL
);
CREATE TABLE orders(
 id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NOT NULL,total_amount DECIMAL(10,2) NOT NULL,
 shipping_name VARCHAR(100) NOT NULL,shipping_phone VARCHAR(30) NOT NULL,shipping_address TEXT NOT NULL,
 status ENUM('Pending','Confirmed','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
 payment_method ENUM('COD') DEFAULT 'COD',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE order_items(
 id INT AUTO_INCREMENT PRIMARY KEY,order_id INT NOT NULL,product_id INT NOT NULL,
 product_name VARCHAR(150) NOT NULL,quantity INT NOT NULL,unit_price DECIMAL(10,2) NOT NULL,
 line_total DECIMAL(10,2) NOT NULL,FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(id)
);
CREATE TABLE inventory_movements(
 id INT AUTO_INCREMENT PRIMARY KEY,product_id INT NOT NULL,change_quantity INT NOT NULL,
 reason VARCHAR(100) NOT NULL,reference_order_id INT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(product_id) REFERENCES products(id),FOREIGN KEY(reference_order_id) REFERENCES orders(id) ON DELETE SET NULL
);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_products_category ON products(category_id);
INSERT IGNORE INTO categories(name) VALUES('Electronics'),('Clothing'),('Home & Living'),('Accessories');
INSERT INTO products(category_id,name,description,price,stock_quantity,image_url)
SELECT id,'Wireless Headphones','Wireless headphones for everyday use.',2499,15,'https://placehold.co/700x500?text=Headphones'
FROM categories WHERE name='Electronics' AND NOT EXISTS(SELECT 1 FROM products WHERE name='Wireless Headphones');
INSERT INTO products(category_id,name,description,price,stock_quantity,image_url)
SELECT id,'Classic T-Shirt','Comfortable cotton T-shirt.',999,30,'https://placehold.co/700x500?text=T-Shirt'
FROM categories WHERE name='Clothing' AND NOT EXISTS(SELECT 1 FROM products WHERE name='Classic T-Shirt');
