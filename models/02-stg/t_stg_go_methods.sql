/*-------------------------------------------------------------------------------
Program:        t_stg_go_methods
Project:        duckdb-core-sample-go-sales
Description:    Staging model for GO Sales order methods
                 with raw data from source
Input(s):       raw.t_raw_go_methods
Output(s):      stg.t_stg_go_methods
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

select  "Order method code" as order_method_code,  
        "Order method type" as order_method_type
from    {{ ref('t_raw_go_methods') }}