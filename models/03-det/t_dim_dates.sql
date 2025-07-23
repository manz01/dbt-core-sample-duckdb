/*------------------------------------------------------------------------------
Program:        t_dim_dates.sql
Project:        duckdb-core-sample-go-sales
Description:    Dimension model for GO Sales dates with various date attributes
                 including year, month, day, week, and weekend/weekday flags
Input(s):       date_span
Output(s):      det.t_dim_dates
Author:         Manzar Ahmed
First Created:  Jul 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-07-06  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

{{ config(
    materialized = 'table',
    schema = 'det'
) }}

with date_span as (
    select 
        cast('2000-01-01' as date) + cast(i as integer) as full_date
    from range(0, 365 * 50) as t(i)
),

dim_dates as (
    select 
        cast(full_date as date) as date_key,
        full_date,
        cast(strftime('%Y', full_date) as integer) as year,
        cast(strftime('%m', full_date) as integer) as month,
        cast(strftime('%d', full_date) as integer) as day,
        cast(strftime('%W', full_date) as integer) as week_of_year,
        cast(strftime('%w', full_date) as integer) as weekday_number,
        cast(strftime('%j', full_date) as integer) as day_of_year,
        strftime('%Y-%m', full_date) as month_label,
        strftime('%Y-%W', full_date) as week_label,
        strftime('%Y-Q', full_date) || cast(((cast(strftime('%m', full_date) as integer) - 1) / 3 + 1) as integer) as quarter_label,
        case when strftime('%w', full_date) in ('0','6') then true else false end as is_weekend,
        case when strftime('%w', full_date) in ('1','2','3','4','5') then true else false end as is_weekday
    from date_span
)

select * from dim_dates