# 🏏 Cricket Data Warehouse

A Snowflake-based data warehouse project that ingests live cricket data from a public sports API and transforms it through a layered pipeline into an analytics-ready star schema.

## 📌 Project Overview

This project simulates a real-world data engineering workflow — taking raw, semi-structured cricket match data and progressively cleaning, validating, and modeling it for analytical use. It follows a **multi-zone (medallion-style) architecture**, a common pattern used in modern data warehouses.

Built as a hands-on portfolio project to practice:
- Data warehouse design (star schema, fact/dimension modeling)
- SQL-based ETL/ELT pipelines in Snowflake
- Data quality validation
- Structuring a data project for real-world maintainability

## 🏗️ Architecture

```
API Source (Cricbuzz/ESPN)
        │
        ▼
┌───────────────┐
│   Raw Zone    │  → Landing zone for unprocessed API data
└───────┬───────┘
        ▼
┌───────────────┐
│  Clean Zone   │  → Standardization, type casting, deduplication
│  (3 stages)   │     across multiple source entities
└───────┬───────┘
        ▼
┌───────────────┐
│ Data Quality  │  → Validation checks and rules before modeling
└───────┬───────┘
        ▼
┌───────────────┐
│ Fact & Dim    │  → Star schema: fact tables + dimension tables
│    Tables     │     (e.g., date_dim, referee_dim)
└───────────────┘
```

## 📁 Repository Structure

```
cricket-data-warehouse/
├── Notebooks/
│   └── schema creation.ipynb      # Initial database/schema setup
├── sql/
│   ├── sql1_raw_zone.sql          # Raw data ingestion layer
│   ├── sql2_clean_zone_1.sql      # Cleaning stage 1
│   ├── sql3_clean_zone_2.sql      # Cleaning stage 2
│   ├── sql4_clean_zone_3.sql      # Cleaning stage 3
│   ├── sql5_data_quality.sql      # Data validation & quality checks
│   └── sql6_fact_dim_tables.sql   # Fact & dimension table creation
└── README.md
```

## 🛠️ Tech Stack

- **Snowflake** — cloud data warehouse
- **SQL** — DDL, transformations, data quality checks
- **Jupyter Notebook** — schema setup and orchestration
- **Public Cricket API** — source data (match stats, players, teams, referees, etc.)

## 🔑 Key Concepts Demonstrated

- **Layered data architecture** (raw → clean → curated)
- **Dimensional modeling** — building fact and dimension tables (e.g. `date_dim`, `referee_dim`) for analytical querying
- **Data quality gating** — validating data before it reaches the modeled layer
- **Role/warehouse/schema management** in Snowflake (`use role`, `use warehouse`, `use schema`)

## 🚀 How to Use

1. Clone this repository
   ```bash
   git clone https://github.com/<your-username>/cricket-data-warehouse.git
   ```
2. Open the SQL scripts in a Snowflake worksheet (or Snowsql/CLI)
3. Run scripts in order: `sql1_raw_zone.sql` → `sql6_fact_dim_tables.sql`
4. Adjust `use warehouse` / `use role` statements to match your own Snowflake account setup

> ⚠️ **Note:** No credentials, API keys, or account identifiers are included in this repo. You'll need your own Snowflake account and API access to run the pipeline end-to-end.

## 📈 Future Improvements

- Automate ingestion with Snowflake Tasks/Streams or an orchestration tool (Airflow/dbt)
- Add BI dashboard (Tableau/Power BI/Streamlit) on top of the fact/dim layer
- Expand data quality checks with a framework like Great Expectations
- Add CI/CD for SQL deployment (schemachange or dbt)

## 👤 Author

Built as a personal portfolio project to demonstrate data engineering and warehousing skills using Snowflake.
