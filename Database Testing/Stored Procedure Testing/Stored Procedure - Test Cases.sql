USE classicmodels;

SHOW PROCEDURE STATUS
WHERE db =  'classicmodels';

SHOW PROCEDURE STATUS
WHERE name = 'SelectAllCustomers';

-- CALL Stored Procedure
CALL SelectAllCustomers();

-- Test Query
SELECT *
FROM customers;

-- CALL Stored Procedure
CALL SelectAllCustomersByCity('Singapore');

-- Test Query
SELECT * 
FROM customers
WHERE city = 'Singapore';

-- CALL Stored Procedure
CALL SelectAllCustomersByCityAndPin('Nantes', '44000');

-- Test Query
SELECT * 
FROM customers
WHERE city = 'Nantes'
AND postalCode = '44000';

-- CALL Stored Procedure
CALL GetOrderByCustomers(141, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;

-- Test Query
SELECT
(SELECT COUNT(*) AS 'shipped' FROM orders WHERE customerNumber = 141 AND status = 'Shipped') AS Shipped,
(SELECT COUNT(*) AS 'canceled' FROM orders WHERE customerNumber = 141 AND status = 'Canceled') AS Canceled,
(SELECT COUNT(*) AS 'resolved' FROM orders WHERE customerNumber = 141 AND status = 'Resolved') AS Resolved,
(SELECT COUNT(*) AS 'disputed' FROM orders WHERE customerNumber = 141 AND status = 'Disputed') AS Disputed;

-- CALL Stored Procedure
CALL GetCustomersShipping(112, @shipping_time);
SELECT @shipping_time;

CALL GetCustomersShipping(260, @shipping_time);
SELECT @shipping_time;

CALL GetCustomersShipping(353, @shipping_time);
SELECT @shipping_time;

-- Test Query
SELECT country,
CASE
	WHEN country = 'USA' THEN '2-day Shipping'
	WHEN country = 'Canada' THEN '3-day Shipping'
	ELSE '5-day Shipping'
END AS ShippingTime
FROM customers
WHERE customerNumber = 112;


