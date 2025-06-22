/*-------------------------------------------------------------------------------
Program:        t_stg_go_retailers
Project:        duckdb-core-sample-go-sales
Description:    Staging model for GO Sales retailers
                with raw data from source
Input(s):       raw.t_raw_go_retailers
Output(s):      stg.t_stg_go_retailers
Author:         Manzar Ahmed
First Created:  Jun 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
-------------------------------------------------------------------------------*/

select  "Retailer code" as retailer_code, 
        "Retailer name" as retailer_name, 
        "Type" as type, 
        "Country" as country
from    {{ ref('t_raw_go_retailers') }}