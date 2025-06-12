/*-------------------------------------------------------------------------------
Program:        t_stg_go_products
Project:        duckdb-core-sample-go-sales
Description:    Staging model for GO Sales products
                 with raw data from source
Input(s):       raw.t_raw_go_products
Output(s):      stg.t_stg_go_products
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

select  "Product number" as product_number, 
        "Product line" as product_line, 
        "Product type" as product_type,  
        "Product" as product, 
        "Product brand" as product_brand, 
        "Product color" as product_color, 
        "Unit cost" as unit_cost, 
        "Unit price" as unit_price
from     {{ ref('t_raw_go_products') }}