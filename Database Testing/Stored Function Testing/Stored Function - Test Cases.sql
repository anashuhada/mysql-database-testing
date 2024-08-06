SHOW FUNCTION STATUS
WHERE db =  'classicmodels';

SHOW FUNCTION STATUS
WHERE Name = 'CustomerLevel';

-- CALL Stored Function
SELECT customerName, CustomerLevel(creditLimit) FROM customers;

-- Test Query
SELECT customerName,
CASE
WHEN creditLimit > 50000 THEN 'PLATINUM'
WHEN creditLimit >= 10000 AND creditLimit < 50000 THEN 'GOLD'
WHEN creditLimit < 10000 THEN 'SILVER'
END AS customerLevel
FROM customers;

-- CALL Stored Procedure
CALL GetCustomerLevel(131, @customerLevel);
SELECT @customerLevel;

-- Test Query
SELECT customerName,
CASE
WHEN creditLimit > 50000 THEN 'PLATINUM'
WHEN creditLimit >= 10000 AND creditLimit < 50000 THEN 'GOLD'
WHEN creditLimit < 10000 THEN 'SILVER'
END AS customerLevel
FROM customers
WHERE customerNumber = 131;

