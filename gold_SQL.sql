-- Databricks notebook source
SELECT *
FROM workspace.sales_customers.gold_sales_by_shop
ORDER BY revenue DESC
LIMIT 10;

-- COMMAND ----------

CREATE OR REPLACE TABLE workspace.sales_customers.gold_sales_by_day AS
SELECT
  sale_date,
  COUNT(*)         AS num_sales,
  SUM(totalPrice)  AS revenue
FROM workspace.sales_customers.silver_sales_transactions
GROUP BY sale_date;

-- COMMAND ----------

CREATE OR REPLACE TABLE workspace.sales_customers.gold_sales_by_product AS
SELECT
  product,
  COUNT(*)         AS num_sales,
  SUM(quantity)    AS items_sold,
  SUM(totalPrice)  AS revenue
FROM workspace.sales_customers.silver_sales_transactions
GROUP BY product;

-- COMMAND ----------

CREATE OR REPLACE TABLE workspace.sales_customers.gold_sales_by_shop AS
SELECT
  franchise_name,
  city,
  country,
  COUNT(*)         AS num_sales,
  SUM(quantity)    AS items_sold,
  SUM(totalPrice)  AS revenue
FROM workspace.sales_customers.silver_sales_transactions
GROUP BY franchise_name, city, country;