-- Retail Sales & Profitability Analytics
-- MySQL 8.x recommended. Run this script in MySQL Workbench.
-- Update the CSV paths below to the absolute paths on YOUR computer.
-- LOCAL INFILE reads from the client computer. If disabled, see the guide after this script.

CREATE DATABASE IF NOT EXISTS retail_analytics;
USE retail_analytics;

DROP TABLE IF EXISTS returns;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    row_id INT NOT NULL,
    order_id VARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(40),
    customer_id VARCHAR(30) NOT NULL,
    customer_name VARCHAR(120),
    segment VARCHAR(40),
    country_region VARCHAR(80),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(40),
    product_id VARCHAR(40) NOT NULL,
    category VARCHAR(60),
    sub_category VARCHAR(60),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(6,4),
    profit DECIMAL(12,2),
    PRIMARY KEY (row_id),
    INDEX idx_orders_order_id (order_id),
    INDEX idx_orders_order_date (order_date),
    INDEX idx_orders_customer_id (customer_id),
    INDEX idx_orders_product_id (product_id),
    INDEX idx_orders_region (region)
);

CREATE TABLE people (
    person VARCHAR(120),
    region VARCHAR(40) NOT NULL,
    UNIQUE KEY uq_people_region (region)
);

CREATE TABLE returns (
    order_id VARCHAR(30) NOT NULL,
    returned VARCHAR(10),
    PRIMARY KEY (order_id),
    INDEX idx_returns_returned (returned)
);

-- Replace these example paths with your actual paths.
-- Windows paths in MySQL string literals should use forward slashes.
LOAD DATA LOCAL INFILE 'C:/REPLACE_WITH_PATH/Superstore_SQL_Python_Project/data/orders.csv'
INTO TABLE orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(row_id, order_id, order_date, ship_date, ship_mode, customer_id, customer_name,
 segment, country_region, city, state_province, postal_code, region, product_id,
 category, sub_category, product_name, sales, quantity, discount, profit);

LOAD DATA LOCAL INFILE 'C:/REPLACE_WITH_PATH/Superstore_SQL_Python_Project/data/people.csv'
INTO TABLE people
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(person, region);

LOAD DATA LOCAL INFILE 'C:/REPLACE_WITH_PATH/Superstore_SQL_Python_Project/data/returns.csv'
INTO TABLE returns
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, returned);

-- Validate import
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'people', COUNT(*) FROM people
UNION ALL
SELECT 'returns', COUNT(*) FROM returns;

-- Basic quality checks
SELECT COUNT(*) AS orders_rows FROM orders;
SELECT COUNT(DISTINCT order_id) AS distinct_orders FROM orders;
SELECT COUNT(DISTINCT customer_id) AS distinct_customers FROM orders;
SELECT COUNT(*) AS null_sales_rows FROM orders WHERE sales IS NULL;
SELECT COUNT(*) AS negative_profit_lines FROM orders WHERE profit < 0;
SELECT MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date FROM orders;
