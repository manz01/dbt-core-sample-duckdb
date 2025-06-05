select  "Retailer code" as retailer_code, 
        "Retailer name" as retailer_name, 
        "Type" as type, 
        "Country" as country
from    {{ ref('t_raw_go_retailers') }}