/*Для каждого дня в диапазоне с 2017-04-01 по 2017-04-09 включительно 
вывести количество подтвержденных онлайн-заказов и количество уникальных клиентов, 
совершивших эти заказы.*/

SELECT
	o.order_date AS date,
	count(DISTINCT customer_id) AS unique_customer,
	count(*) AS num_orders
FROM
	orders o
WHERE
	o.order_date BETWEEN '2017-04-01'::date AND '2017-04-09'::date
	AND o.order_status = 'Approved'
	AND o.online_order = TRUE
GROUP BY
	o.order_date
ORDER BY
	o.order_date ;