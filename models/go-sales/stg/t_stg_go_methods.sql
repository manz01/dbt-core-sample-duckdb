select  "Order method code" as order_method_code,  
        "Order method type" as order_method_type
from    {{ ref('t_raw_go_methods') }}