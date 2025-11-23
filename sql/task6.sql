/*Вывести всех клиентов (ID, имя, фамилия), у которых нет подтвержденных онлайн-заказов 
за последний год, но при этом они владеют автомобилем и их сегмент 
благосостояния не Mass Customer.*/

WITH last_order_date AS (
    SELECT MAX(order_date) AS max_date -- здесь так иначе очевидно будет ноль :)
    FROM orders
),

last_year AS (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.online_order = TRUE
      AND o.order_status = 'Approved'
      AND o.order_date >= (SELECT max_date FROM last_order_date) - INTERVAL '1 year'
)

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
WHERE c.owns_car = TRUE
  AND c.wealth_segment <> 'Mass Customer'
  AND c.customer_id NOT IN (
        SELECT customer_id 
        FROM last_year
     )
ORDER BY c.customer_id;

