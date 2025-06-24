/*-------------------------------------------------------------------------------
Program:        t_fct_sales
Project:        duckdb-core-sample-go-sales
Description:    Fact table for GO Sales with surrogate keys from dimensions
Input(s):       stg.t_stg_go_daily_sales
Output(s):      fct.t_fct_sales
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

{{ config(
    materialized='incremental',
    schema='det',
    unique_key='fct_sales_sk',
    on_schema_change='sync_all_columns',
    pre_hook=["create sequence if not exists seq_fct_sales_sk start 1 increment 1"]
) }}

{% do run_query("SET VARIABLE current_ts = (SELECT date_trunc('second', current_timestamp));") %}
{%- set high_date = '9999-12-31 00:00:00' %}

with base as (
    select      s.retailer_code,
                s.product_number,
                s.order_method_code,
                s.transaction_date::date as transaction_date,
                s.quantity,
                s.unit_price,
                s.unit_sale_price
    from        {{ ref('t_stg_go_daily_sales') }} s
    order by    s.transaction_date, 
                s.retailer_code, 
                s.product_number, 
                s.order_method_code
),

joined as (
    select      nextval('seq_fct_sales_sk') as fct_sales_sk,
                ---------------------------------------------
                r.dim_retailer_sk,
                p.dim_product_sk,
                m.dim_order_method_sk,
                ---------------------------------------------
                b.transaction_date,
                b.quantity,
                b.unit_price,
                b.unit_sale_price,
                ---------------------------------------------
                getvariable('current_ts') as create_ts,
                getvariable('current_ts') as update_ts

    from        base b
    left join   {{ ref('t_dim_retailers') }} r
    on          b.retailer_code = r.retailer_code
    and         r.end_ts = ('{{ high_date }}')::timestamp

    left join   {{ ref('t_dim_products') }} p
    on          b.product_number = p.product_number
    and         p.end_ts = ('{{ high_date }}')::timestamp

    left join   {{ ref('t_dim_order_method') }} m
    on          b.order_method_code = m.order_method_code
)

select * from joined

{% if is_incremental() %}
    where ( dim_retailer_sk, 
            dim_product_sk, 
            dim_order_method_sk, 
            transaction_date) 
    not in (
        select  dim_retailer_sk, 
                dim_product_sk, 
                dim_order_method_sk, 
                transaction_date
        from    {{ this }}
    )
{% endif %}
