/*
SELECT *
FROM orders
WHERE order_status IS 'unpaid';

SELECT *
FROM customers;

SELECT *
FROM subscriptions;

--------------------------------

SELECT orders.*, customer_name
FROM orders
LEFT JOIN customers
    ON orders.customer_id =
    customers.customer_id
WHERE orders.order_status IS 'unpaid';

---------------------------------------

SELECT orders.*
,customer_name
,price_per_month * subscription_length
AS 'Amount_Due'
FROM orders
LEFT JOIN customers
    ON orders.customer_id =
    customers.customer_id
LEFT JOIN subscriptions
    ON orders.subscription_id =
    subscriptions.subscription_id
WHERE orders.order_status IS 'unpaid';

----------------------------------------

SELECT
customer_name
,price_per_month * subscription_length
AS 'Amount_Due'
FROM orders
LEFT JOIN customers
    ON orders.customer_id =
    customers.customer_id
LEFT JOIN subscriptions
    ON orders.subscription_id =
    subscriptions.subscription_id
WHERE orders.order_status IS 'unpaid'
    AND subscriptions.description IS 'Fashion Magazine';

-------------------------------------------------------

SELECT
customer_name
,PRINTF('$%.2f'
    ,price_per_month * subscription_length)
AS 'Amount_Due'
FROM orders
LEFT JOIN customers
    ON orders.customer_id =
    customers.customer_id
LEFT JOIN subscriptions
    ON orders.subscription_id =
    subscriptions.subscription_id
WHERE orders.order_status IS 'unpaid'
    AND subscriptions.description IS 'Fashion Magazine';
*/


WITH temp AS (
SELECT
customer_name
    ,sum(price_per_month * subscription_length) as 'Amount_Due'

FROM orders
LEFT JOIN customers
    ON orders.customer_id =
    customers.customer_id
LEFT JOIN subscriptions
    ON orders.subscription_id =
    subscriptions.subscription_id
WHERE orders.order_status IS 'unpaid'
    AND subscriptions.description IS 'Fashion Magazine'
    GROUP BY customer_name
)

SELECT customer_name
    ,printf('$%.2f',amount_due) AS Amount_due
FROM temp
;