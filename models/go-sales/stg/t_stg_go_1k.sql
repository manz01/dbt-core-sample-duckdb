/*------------------------------------------------------------------------------------------------
Program:        t_stg_go_1k
Project:        duckdb-core-sample-go-sales
Description:    Staging model for the GO Sales data go_1k
Input(s):       raw.t_raw_go_1k
Output(s):      det.t_stg_go_1k
Author:         Manzar Ahmed
First Created:  Feb 2025
-------------------------------------------------------------------------------------------------
Program history:
-------------------------------------------------------------------------------------------------
Date        Programmer                Description
----------  ------------------------  -----------------------------------------------------------
2023-02-01  Manzar Ahmed              v0.01/Initial version
------------------------------------------------------------------------------------------------*/

select    "Retailer code" as retailer_code,
          "Product number" as product_number,
          "Date"::date as transaction_date,
          "Quantity" as quantity

from      {{ ref('t_raw_go_1k') }}