/*Вывести клиентов (ID, имя, фамилия, сфера деятельности) из сфер IT или Health, 
которые совершили не менее 3 подтвержденных заказов в 
период 2017-01-01 по 2017-03-01, и при этом их общий доход от этих 
заказов превышает 10 000 долларов.
Разделить вывод на две группы (IT и Health) с помощью UNION.*/

WITH it_orders AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.job_industry_category
    FROM customer c
    JOIN orders o
        ON o.customer_id = c.customer_id
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE c.job_industry_category = 'IT'
      AND o.order_status = 'Approved'
      AND o.order_date BETWEEN '2017-01-01' AND '2017-03-01'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.job_industry_category
    HAVING COUNT(DISTINCT o.order_id) >= 3
       AND SUM(oi.item_list_price_at_sale * oi.quantity) > 10000
),

health_orders AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.job_industry_category
    FROM customer c
    JOIN orders o
        ON o.customer_id = c.customer_id
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE c.job_industry_category = 'Health'
      AND o.order_status = 'Approved'
      AND o.order_date BETWEEN '2017-01-01' AND '2017-03-01'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.job_industry_category
    HAVING COUNT(DISTINCT o.order_id) >= 3
       AND SUM(oi.item_list_price_at_sale * oi.quantity) > 10000
)

SELECT * FROM it_orders
UNION ALL
SELECT * FROM health_orders
ORDER BY job_industry_category, customer_id;