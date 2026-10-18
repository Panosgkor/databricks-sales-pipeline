-- Databricks notebook source
CREATE OR REPLACE TABLE workspace.sales_customers.bronze_sales_franchises AS
SELECT
  *,
  current_timestamp()  AS _ingested_at,
  _metadata.file_path  AS _source_file
FROM read_files(
  '/Volumes/workspace/sales_customers/raw_files/sales_franchises',
  format => 'csv',
  header => true
);

-- COMMAND ----------

CREATE OR REPLACE TABLE workspace.sales_customers.bronze_sales_transactions AS
SELECT
  *,
  current_timestamp()  AS _ingested_at,
  _metadata.file_path  AS _source_file
FROM read_files(
  '/Volumes/workspace/sales_customers/raw_files/sales_transactions',
  format => 'csv',
  header => true
);

-- COMMAND ----------

FROM read_files(
  '/Volumes/workspace/sales_customers/raw_files/sales_transactions',
  format => 'csv',
  header => true
);

-- COMMAND ----------

LIST '/Volumes/workspace/sales_customers/raw_files/';