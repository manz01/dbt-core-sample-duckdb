/*-------------------------------------------------------------------------------
Program:        t_stg_go_1k
Project:        duckdb-core-sample-go-sales
Description:    Staging model for GO Sales products transactions
                 with raw data from source
Input(s):       raw.t_raw_go_1k
Output(s):      stg.t_stg_go_1k
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

select    "Retailer code" as retailer_code,
          "Product number" as product_number,
          "Date"::date as transaction_date,
          "Quantity" as quantity

from      {{ ref('t_raw_go_1k') }}