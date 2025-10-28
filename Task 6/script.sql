CREATE DATABASE onlinesales;

ALTER TABLE online_sales
ADD COLUMN Revenue DECIMAL(14,2) AS (Quantity * UnitPrice);

SELECT
  EXTRACT(YEAR FROM InvoiceDate)  AS order_year,
  EXTRACT(MONTH FROM InvoiceDate) AS order_month,
  ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_sales
WHERE InvoiceDate BETWEEN '2020-01-01' AND '2020-12-31'   
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

SELECT
  EXTRACT(YEAR FROM InvoiceDate)  AS order_year,
  EXTRACT(MONTH FROM InvoiceDate) AS order_month,
  ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_sales
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
  EXTRACT(YEAR FROM InvoiceDate)  AS order_year,
  EXTRACT(MONTH FROM InvoiceDate) AS order_month,
  ROUND(SUM(Quantity * UnitPrice),2) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS total_orders,
  ROUND( SUM(Quantity * UnitPrice) / NULLIF(COUNT(DISTINCT InvoiceNo), 0), 2) AS avg_order_value
FROM online_sales
GROUP BY order_year, order_month;

SELECT
  EXTRACT(YEAR FROM InvoiceDate)  AS order_year,
  EXTRACT(MONTH FROM InvoiceDate) AS order_month,
  ROUND(SUM(Quantity * UnitPrice),2) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_sales
WHERE InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

 









