-- 02_business_analysis_queries.sql
USE retail_analytics;


-- Q01 — Overall KPIs
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    SUM(quantity) AS units_sold,
    SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM orders;


-- Q02 — Monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
       SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY order_month;


-- Q03 — Sales by category
SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders GROUP BY category ORDER BY total_sales DESC;


-- Q04 — Profit by sub-category (lowest first)
SELECT sub_category, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM orders GROUP BY sub_category ORDER BY total_profit ASC;


-- Q05 — Sales by region
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders GROUP BY region ORDER BY total_sales DESC;


-- Q06 — Sales by customer segment
SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
       COUNT(DISTINCT customer_id) AS customers
FROM orders GROUP BY segment ORDER BY total_sales DESC;


-- Q07 — Top 10 products by profit
SELECT product_id, product_name, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM orders GROUP BY product_id, product_name
ORDER BY total_profit DESC LIMIT 10;


-- Q08 — Bottom 10 products by profit
SELECT product_id, product_name, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM orders GROUP BY product_id, product_name
ORDER BY total_profit ASC LIMIT 10;


-- Q09 — Discount bands and profitability
SELECT
    CASE
      WHEN discount = 0 THEN '0% (no discount)'
      WHEN discount <= 0.10 THEN '>0%–10%'
      WHEN discount <= 0.20 THEN '>10%–20%'
      WHEN discount <= 0.30 THEN '>20%–30%'
      ELSE '>30%'
    END AS discount_band,
    COUNT(*) AS transaction_lines,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM orders
GROUP BY discount_band
ORDER BY MIN(discount);


-- Q10 — Sales by ship mode
SELECT ship_mode, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
       AVG(DATEDIFF(ship_date, order_date)) AS avg_ship_days
FROM orders GROUP BY ship_mode ORDER BY total_sales DESC;


-- Q11 — Shipping duration distribution
SELECT DATEDIFF(ship_date, order_date) AS ship_days,
       COUNT(*) AS transaction_lines
FROM orders
GROUP BY DATEDIFF(ship_date, order_date)
ORDER BY ship_days;


-- Q12 — Returned order rate by region
WITH order_region AS (
    SELECT order_id, MAX(region) AS region
    FROM orders GROUP BY order_id
),
returned_orders AS (
    SELECT DISTINCT order_id FROM returns
    WHERE LOWER(TRIM(returned)) = 'yes'
)
SELECT o.region,
       COUNT(*) AS distinct_orders,
       COUNT(r.order_id) AS returned_orders,
       COUNT(r.order_id) / COUNT(*) AS returned_order_rate
FROM order_region o
LEFT JOIN returned_orders r ON o.order_id = r.order_id
GROUP BY o.region
ORDER BY returned_order_rate DESC;


-- Q13 — Monthly profit margin
SELECT DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
       SUM(sales) AS total_sales, SUM(profit) AS total_profit,
       SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY order_month;


-- Q14 — Top 10 customers by sales
SELECT customer_id, customer_name,
       SUM(sales) AS total_sales, SUM(profit) AS total_profit,
       COUNT(DISTINCT order_id) AS distinct_orders
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC LIMIT 10;


-- Q15 — Category sales vs profit
SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders GROUP BY category ORDER BY total_sales DESC;


-- Q16 — Quantity sold by category
SELECT category, SUM(quantity) AS units_sold
FROM orders GROUP BY category ORDER BY units_sold DESC;


-- Q17 — Top 10 states by sales
SELECT state_province, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders GROUP BY state_province ORDER BY total_sales DESC LIMIT 10;
