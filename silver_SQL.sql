-- Databricks notebook source
SELECT *
FROM workspace.sales_customers.silver_sales_transactions
LIMIT 5;

-- COMMAND ----------

SELECT COUNT(*) AS silver_rows
FROM workspace.sales_customers.silver_sales_transactions;

-- COMMAND ----------

CREATE OR REPLACE TABLE workspace.sales_customers.silver_sales_transactions AS
SELECT
  t.transactionID,
  t.franchiseID,
  t.dateTime,
  to_date(t.dateTime)                     AS sale_date,
  t.product,
  t.quantity,
  t.unitPrice,
  t.totalPrice,
  lower(trim(t.paymentMethod))            AS payment_method,
  right(CAST(t.cardNumber AS STRING), 4)  AS card_last4,
  f.name                                  AS franchise_name,
  f.city,
  f.country
FROM workspace.sales_customers.bronze_sales_transactions t
LEFT JOIN workspace.sales_customers.bronze_sales_franchises f
  ON t.franchiseID = f.franchiseID
WHERE t.transactionID IS NOT NULL
  AND t.totalPrice IS NOT NULL
  AND t.quantity > 0;