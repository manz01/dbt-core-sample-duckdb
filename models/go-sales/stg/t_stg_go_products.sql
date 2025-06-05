select  "Product number" as product_number, 
        "Product line" as product_line, 
        "Product type" as product_type,  
        "Product" as product, 
        "Product brand" as product_brand, 
        "Product color" as product_color, 
        "Unit cost" as unit_cost, 
        "Unit price" as unit_price
from     {{ ref('t_raw_go_products') }}