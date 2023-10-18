WITH 
  sales AS (SELECT * FROM `gz_raw_data.raw_gz_sales`),
  product AS (SELECT * FROM `gz_raw_data.raw_gz_product`)
  
SELECT
  s.date_date,
  s.orders_id,
  s.pdt_id AS products_id,
  s.quantity AS qty,
  s.revenue AS turnover,
  CAST(p.purchSE_PRICE AS FLOAT64) AS purchase_price,
  ROUND(s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS purchase_cost,
  ROUND(s.revenue-s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS purchase_margin,
  {{ margin_percent('s.revenue', 's.quantity*CAST(p.purchSE_PRICE AS FLOAT64)') }} AS product_margin_percent,
  {{ margin('s.revenue', 's.quantity*CAST(p.purchSE_PRICE AS FLOAT64)') }} AS product_margin 
FROM sales s
INNER JOIN product p ON s.pdt_id = p.products_id
