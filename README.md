# Go Sales

### Document Control
|Version|Date|Author|Description of Change|
|-|-|-|-|
|1.0|2025-05-18|Manzar Ahmed|Initial Version|
|1.1|2025-06-12|Manzar Ahmed|Added DET and MRT model sections|

## Table of Content
- [1. Background](#1-background)
- [2. Run dbt Models](#2-run-dbt-models)
  - [2.1. Raw Models](#21-raw-models)
  - [2.2. Staging Models](#22-staging-models)
  - [2.3. Detailed Models (DET)](#23-detailed-models-det)
  - [2.4. Mart Models (MRT)](#24-mart-models-mrt)

## 1. Background
The GO Sales IBM sample data is a fictional retail dataset designed to demonstrate business analytics, reporting, and data warehousing techniques. It simulates sales operations for a global retailer and contains various interconnected tables that model business domains such as:

- Products: Information on product lines, categories, and individual product details.
- Retailers: Details of retail customers including geographic and organizational attributes.
- Time: A time dimension table to support period-based analysis (e.g., quarters, months, years).
- Sales Facts: Transactional sales data including revenue, quantity sold, and cost measures.
- Targets and Forecasts: Sales targets and forecasting metrics by region, product, and period.
- Promotions: Promotional campaigns associated with specific products and timeframes.
- Inventory and Orders: Stock levels and order history.

It is commonly used in IBM Cognos and other BI tool tutorials to teach OLAP modeling, SQL queries, and dashboarding.

https://dataplatform.cloud.ibm.com/exchange/public/entry/view/dcf7b09bd340e6ff9a2d1869631f3753

## 2. Run dbt Models

### Create Aliases & Global Vars

```sh
# Create DBT Global Vars
export DBT_PROJ_DIR='/home/u001/dbt-core-sample-duckdb'
export DBT_PROFILE_DIR='/home/u001/dbt-core-sample-duckdb'
export PYTHONPATH=$DBT_PROJ_DIR
```

# Create dbt run go sales alias shorthand
```sh
alias dbt_run_go_sales='dbt run --project-dir $DBT_PROJ_DIR --profiles-dir $DBT_PROFILE_DIR --target go_sales'
alias dbt_docs_go_sales='dbt docs generate --project-dir $DBT_PROJ_DIR --profiles-dir $DBT_PROFILE_DIR --target go_sales'
```
## 2.1. Raw Models

```sh
dbt_run_go_sales --select tag:GO_SALES_RAW
```

## 2.2. Staging Models
 
```sh
dbt_run_go_sales --select tag:GO_SALES_STG
```

## 2.3. Detailed Models (DET)

```sh
dbt_run_go_sales --select tag:GO_SALES_DET
```

## 2.4. Mart Models (MRT)

```sh
dbt_run_go_sales --select tag:GO_SALES_MRT
```
