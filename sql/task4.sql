/*Вывести бренды, которые были куплены клиентами из сферы Financial Services, 
но не были куплены клиентами из сферы IT.*/

SELECT
	DISTINCT fs.brand
FROM
	(
	SELECT
		p.brand
	FROM
		order_items oi
	JOIN orders o ON
		o.order_id = oi.order_id
	JOIN customer c ON
		c.customer_id = o.customer_id
	JOIN product_cor p ON
		p.product_id = oi.product_id
	WHERE
		c.job_industry_category = 'Financial Services'
) fs
LEFT JOIN (
	SELECT
		DISTINCT p.brand
	FROM
		order_items oi
	JOIN orders o ON
		o.order_id = oi.order_id
	JOIN customer c ON
		c.customer_id = o.customer_id
	JOIN product_cor p ON
		p.product_id = oi.product_id
	WHERE
		c.job_industry_category = 'IT'
) it
ON
	fs.brand = it.brand
WHERE
	it.brand IS NULL;
