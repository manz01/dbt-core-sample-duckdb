/*-------------------------------------------------------------------------------
Program:        t_stg_go_daily_sales
Project:        duckdb-core-sample-go-sales
Description:    Staging model for GO Sales products daily sales
                with raw data from source
Input(s):       raw.t_raw_go_daily_sales
Output(s):      stg.t_stg_go_daily_sales
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

select
    "Retailer code" as retailer_code,
    "Product number" as product_number,
    "Order method code" as order_method_code,
    date::date as transaction_date,
    quantity,
    "Unit price" as unit_price,
    "Unit sale price" as unit_sale_price

from {{ ref('t_raw_go_daily_sales') }}