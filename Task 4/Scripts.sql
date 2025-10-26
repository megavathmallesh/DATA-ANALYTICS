 SELECT * FROM ecommerce LIMIT 10;
SELECT DISTINCT category FROM ecommerce;
SELECT * FROM ecommerce WHERE category = 'Electronics' AND country = 'canada' LIMIT 50;
SELECT product_id, category, unit_price FROM ecommerce ORDER BY unit_price DESC;
SELECT category, SUM(quantity * unit_price) AS total_sales FROM ecommerce GROUP BY category ORDER BY total_sales DESC;
SELECT country, AVG(quantity * unit_price) AS avg_order_value FROM ecommerce GROUP BY country ORDER BY avg_order_value DESC;

SELECT product_id,
       SUM(quantity * unit_price) AS total_revenue
FROM ecommerce
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    country VARCHAR(100)
);

SELECT c.customer_name, e.product_id, e.category, e.unit_price, e.country
FROM ecommerce e
INNER JOIN customers c
ON e.customer_id = c.customer_id;

SELECT e.order_id, c.customer_name, e.unit_price, e.category
FROM ecommerce e
LEFT JOIN customers c
ON e.customer_id = c.customer_id;

 SELECT 
    product_id, 
    SUM(quantity * unit_price) AS total_sales
FROM ecommerce
GROUP BY product_id
HAVING SUM(quantity * unit_price) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(quantity * unit_price) AS total_sales
        FROM ecommerce
        GROUP BY product_id
    ) AS sub
);

SELECT customer_id, SUM(quantity * unit_price) AS customer_sales
FROM ecommerce
GROUP BY customer_id
HAVING customer_sales > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(quantity * unit_price) AS total_spent
        FROM ecommerce
        GROUP BY customer_id
    ) AS avg_table
);

CREATE VIEW category_summary AS
SELECT category,
       SUM(quantity * unit_price) AS total_sales,
       AVG(unit_price) AS avg_price,
       COUNT(*) AS total_orders
FROM ecommerce
GROUP BY category;

SELECT * FROM category_summary ORDER BY total_sales DESC;

 CREATE INDEX idx_category ON ecommerce (category(100));
CREATE INDEX idx_country ON ecommerce (country(50));

ALTER TABLE ecommerce 
MODIFY order_date DATETIME;

CREATE INDEX idx_order_date ON ecommerce (order_date);

SHOW INDEXES FROM ECOMMERCE

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(quantity * UNIT_price) AS monthly_sales
FROM ecommerce
GROUP BY month
ORDER BY month;


