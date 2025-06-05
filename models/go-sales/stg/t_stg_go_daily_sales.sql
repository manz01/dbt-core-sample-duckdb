select    "Retailer code" as retailer_code,
          "Product number" as product_number,
          "Order method code" as order_method_code,
          "Date"::date as transaction_date,
          "Quantity" as quantity,
          "Unit price" as unit_price,
          "Unit sale price" as unit_sale_price

from      {{ ref('t_raw_go_daily_sales') }}