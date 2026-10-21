# Sales Data Pipeline on Databricks

 Α small ETL pipeline in Databricks with SQL on sample bakery sales data (3,333 sales, 48 shops), following the Bronze → Silver → Gold structure.

## Pipeline
- **Bronze:** CSV files loaded into Delta tables, with load time and source file per row.
- **Silver:** removed invalid rows, standardised payment methods, kept only the last 4 digits of card numbers, joined sales with shop details.
- **Gold:** summary tables of sales and revenue per shop, per product and per day.
- **Checks:** row counts compared between layers; total revenue in Silver matches the sum in each Gold table (66,471).

## Notebooks
- `bronze_sql` – load CSV files into Delta tables
- `silver_sql` – cleaning and join
- `gold_sql` – summary tables

**Tools:** Databricks Free Edition, SQL, Delta Lake
