/*Вывести всех клиентов из сферы 'IT' (ID, имя, фамилия), 
которые купили 2 из 5 продуктов с самой высокой 
list_price в продуктовой линейке Road.*/

WITH top5_prices AS (
SELECT
	DISTINCT list_price
FROM
	product_cor
WHERE
	product_line = 'Road'
ORDER BY
	list_price DESC
LIMIT 5
),

top5_products AS (
SELECT
	product_id
FROM
	product_cor
WHERE
	product_line = 'Road'
	AND list_price IN (
	SELECT
		list_price
	FROM
		top5_prices)
),

it_customers_25 AS (
SELECT
	o.customer_id
FROM
	orders o
JOIN order_items oi ON
	oi.order_id = o.order_id
JOIN top5_products t5 ON
	t5.product_id = oi.product_id
JOIN customer c ON
	c.customer_id = o.customer_id
WHERE
	c.job_industry_category = 'IT'
GROUP BY
	o.customer_id
HAVING
	COUNT(DISTINCT oi.product_id) = 2
)

SELECT
	c.customer_id,
	c.first_name,
	c.last_name
FROM
	customer c
JOIN it_customers_25 t 
    ON
	c.customer_id = t.customer_id
ORDER BY
	c.customer_id;



----------------- test ----------

/*WITH top5_prices AS (
    SELECT DISTINCT list_price
    FROM product_cor
    WHERE product_line = 'Road'
    ORDER BY list_price DESC
    LIMIT 5
)
SELECT 
    pc.list_price,
    COUNT(*) AS product_count
FROM product_cor pc
JOIN top5_prices t5 
      ON pc.list_price = t5.list_price
WHERE pc.product_line = 'Road'
GROUP BY pc.list_price
ORDER BY pc.list_price DESC;*/



