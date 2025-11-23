/*Вывести 10 клиентов (ID, имя, фамилия), которые совершили наибольшее 
количество онлайн-заказов (в штуках) брендов Giant Bicycles, Norco Bicycles, 
Trek Bicycles, при условии, что они активны и имеют оценку 
имущества (property_valuation) выше среднего среди клиентов из того же штата.*/

WITH avg_state_pval AS (
SELECT
	state,
	AVG(property_valuation) AS avg_pval
FROM
	customer
GROUP BY
	state
),

qualified_customers AS (
SELECT
	c.customer_id
FROM
	customer c
JOIN avg_state_pval a 
        ON
	c.state = a.state
WHERE
	c.deceased_indicator = FALSE
	AND c.property_valuation > a.avg_pval
),

brand_orders AS (
SELECT
	o.customer_id,
	COUNT(*) AS num_orders
FROM
	orders o
JOIN order_items oi 
        ON
	oi.order_id = o.order_id
JOIN product_cor p 
        ON
	p.product_id = oi.product_id
JOIN qualified_customers qc
        ON
	qc.customer_id = o.customer_id
WHERE
	o.online_order = TRUE
	AND o.order_status = 'Approved'
	AND p.brand IN ('Giant Bicycles', 'Norco Bicycles', 'Trek Bicycles')
GROUP BY
	o.customer_id
ORDER BY o.customer_id
),

top10 AS (
SELECT
	customer_id,
	num_orders
FROM
	brand_orders
ORDER BY
	num_orders DESC
LIMIT 10
)

SELECT
	c.customer_id,
	c.first_name,
	c.last_name
FROM
	customer c
JOIN top10 t 
    ON
	c.customer_id = t.customer_id;
