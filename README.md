# Sales Data Pipeline on Databricks

Learning project: a small ETL pipeline in Databricks with SQL on sample bakery sales data (3,333 sales, 48 shops), following the Bronze → Silver → Gold structure.

## Pipeline
- **Bronze:** CSV files loaded into Delta tables, with load time and source file per row. Row counts checked against the source.
- **Silver:** removed invalid rows, standardised payment methods, kept only the last 4 digits of card numbers, joined sales with shop details.
- **Gold:** summary tables of sales and revenue per shop, per product and per day.

## Notebooks
- `bronze_sql` – load CSV files into Delta tables
- `silver_sql` – cleaning and join
- `gold_sql` – summary tables

**Tools:** Databricks Free Edition, SQL, Delta Lake
