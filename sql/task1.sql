/* 1. Вывести все уникальные бренды, у которых есть хотя бы один 
продукт со стандартной стоимостью выше 1500 долларов, 
и суммарными продажами не менее 1000 единиц.*/

SELECT
	DISTINCT brand
FROM
	product_cor
WHERE
	standard_cost > 1500
	AND product_id IN 
(
	SELECT
		oi.product_id
	FROM
		order_items oi
	GROUP BY
		oi.product_id
	HAVING
		sum(oi.quantity)>= 1000);

