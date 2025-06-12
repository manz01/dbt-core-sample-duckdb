/*------------------------------------------------------------------------------
Program:        t_dim_products
Project:        duckdb-core-sample-go-sales
Description:    SCD2 dimension model for GO Sales products with surrogate key 
                and change hash
Input(s):       stg.t_stg_go_products
Output(s):      det.t_dim_products
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
    materialized = 'incremental',
    schema = 'det',
    unique_key = 'product_number',
    pre_hook = ["create sequence if not exists seq_dim_product_sk start 1 increment 1"]
) }}


-- Set start_ts with second precision
{% do run_query("SET VARIABLE start_ts = (SELECT date_trunc('second', current_timestamp));") %}
-- Subtract 1 second from the stored timestamp
{% do run_query("SET VARIABLE end_ts = (SELECT cast(getvariable('start_ts') AS timestamp) - INTERVAL 1 SECOND);") %}

{%- set high_date = '9999-12-31 00:00:00' %}

with current_data as (
    select
        product_number,
        product_line,
        product_type,
        product,
        product_brand,
        product_color,
        unit_cost,
        unit_price,
        md5(
            coalesce(product_line, '') || '|' ||
            coalesce(product_type, '') || '|' ||
            coalesce(product, '') || '|' ||
            coalesce(product_brand, '') || '|' ||
            coalesce(product_color, '') || '|' ||
            coalesce(cast(unit_cost as varchar), '') || '|' ||
            coalesce(cast(unit_price as varchar), '')
        ) as scd2_hash
    from {{ ref('t_stg_go_products') }}
)

{% if is_incremental() %},

existing_records as (
    select
        product_number,
        product_line,
        product_type,
        product,
        product_brand,
        product_color,
        unit_cost,
        unit_price,
        scd2_hash,
        start_ts,
        end_ts
    from {{ this }}
    where end_ts = ('{{ high_date }}')::timestamp
),

ordered_changes as (
    select
        c.product_number,
        c.product_line,
        c.product_type,
        c.product,
        c.product_brand,
        c.product_color,
        c.unit_cost,
        c.unit_price,
        c.scd2_hash
    from current_data c
    left join existing_records e
        on c.product_number = e.product_number
    where e.product_number is null
       or c.scd2_hash != e.scd2_hash
    order by c.product_number
),

changes as (
    select
        nextval('seq_dim_product_sk') as dim_product_sk,
        oc.product_number,
        oc.product_line,
        oc.product_type,
        oc.product,
        oc.product_brand,
        oc.product_color,
        oc.unit_cost,
        oc.unit_price,
        oc.scd2_hash,
        getvariable('start_ts') as start_ts,
        ('{{ high_date }}')::timestamp as end_ts
    from ordered_changes oc
),

updates as (
    select
        null as dim_product_sk,
        e.product_number,
        e.product_line,
        e.product_type,
        e.product,
        e.product_brand,
        e.product_color,
        e.unit_cost,
        e.unit_price,
        e.scd2_hash,
        e.start_ts,
        getvariable('end_ts') as end_ts
    from existing_records e
    join changes c
      on e.product_number = c.product_number
    where e.end_ts = ('{{ high_date }}')::timestamp
)

select * from changes
union all
select * from updates

{% else %}

select
    nextval('seq_dim_product_sk') as dim_product_sk,
    product_number,
    product_line,
    product_type,
    product,
    product_brand,
    product_color,
    unit_cost,
    unit_price,
    scd2_hash,
    getvariable('start_ts') as start_ts,
    ('{{ high_date }}')::timestamp as end_ts
from current_data
order by product_number

{% endif %}
