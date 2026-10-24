# Sales Data Pipeline on Databricks

A batch ELT pipeline in Databricks, written in SQL, on the Databricks bakehouse sample sales data (3,333 sales, 48 shops). It follows the medallion architecture: Bronze → Silver → Gold.

```
CSV files in a Unity Catalog volume
  → Bronze: raw Delta tables + load metadata
  → Silver: cleaned, masked and joined
  → Gold: summary tables for reporting
```

## Pipeline
- **Bronze** (`bronze_SQL.sql`): loads the CSV files into Delta tables with `read_files`, and adds `_ingested_at` (load time) and `_source_file` (source file) to every row for lineage.
- **Silver** (`silver_SQL.sql`): removes rows without an ID or price and rows with zero or negative quantity, standardises payment methods with `lower(trim())`, keeps only the last 4 digits of card numbers, and joins each sale with its shop using a LEFT JOIN, so no sale is lost.
- **Gold** (`gold_SQL.sql`): sales and revenue per shop, per product and per day.

## Data quality checks
- Row counts compared between Bronze and Silver.
- Revenue reconciliation: total revenue in Silver matches the sum of each Gold table (66,471).

## How to run
1. In a Databricks workspace (Free Edition works), create the schema and the volume:
   ```sql
   CREATE SCHEMA IF NOT EXISTS workspace.sales_customers;
   CREATE VOLUME IF NOT EXISTS workspace.sales_customers.raw_files;
   ```
2. Put the sales CSV files in `/Volumes/workspace/sales_customers/raw_files/sales_transactions/` and the shop CSV files in `/Volumes/workspace/sales_customers/raw_files/sales_franchises/`.
3. Import the three `.sql` files as notebooks and run them with **Run all**, in order: bronze → silver → gold.

Every step uses `CREATE OR REPLACE TABLE`, so the pipeline can be re-run safely without duplicating data.

## Next steps
- Incremental loading with Auto Loader and `MERGE`
- Data quality expectations and a scheduled Lakeflow Job
- A deduplication step on `transactionID`

**Tools:** Databricks Free Edition, Spark SQL, Delta Lake, Unity Catalog
