-- Built in Functions in MySQL
USE hr;

-- String Functions
-- UPPER()
SELECT UPPER(first_name)
FROM employees;

-- LOWER()
SELECT LOWER(first_name)
FROM employees;

-- LENGTH()
SELECT LENGTH(first_name)
FROM employees;

-- Print names of employees whose name has 4 characters
SELECT *
FROM employees
WHERE LENGTH(first_name) = 4;

-- Equivalent to this
SELECT *
FROM employees
WHERE first_name LIKE '____';

-- TRIM()
SELECT TRIM('   Welcome ');
SELECT TRIM('z' from 'zzoraclezz');

-- INSTR(); position of the character
SELECT INSTR('Welcome', 'o');

-- SUBSTR('string', start, length)
SELECT SUBSTR('MySQL', 2, 1);
SELECT SUBSTRING('MySQL', 2, 3);

SELECT SUBSTR(first_name, 2, 3)
FROM employees;

-- CONCAT()
SELECT CONCAT('Oracle', 'MySQL');
SELECT CONCAT(first_name, ' '  ,last_name) Fullname
FROM employees;

-- Numeric Functions
SELECT ABS(-40);
SELECT ABS(40);
SELECT SQRT(25);
SELECT MOD(10, 3); -- division
SELECT POWER(2, 5);
SELECT TRUNCATE(40.123456, 3);
SELECT TRUNCATE(40.123456, 2);
SELECT TRUNCATE(6859.123456, -1);
SELECT TRUNCATE(6859.123456, -3);
SELECT GREATEST(100, 200, 300, 400, 500);
SELECT LEAST(100, 200, 300, 400, 500);

-- Date Functions
SELECT CURDATE();
SELECT CURRENT_DATE();
SELECT CURTIME();
SELECT CURRENT_TIME();
SELECT NOW();
SELECT SYSDATE();
SELECT MONTH('2024-07-25 15:13:21');
SELECT YEAR('2024-07-25 15:13:21');
SELECT DAY('2024-07-25 15:13:21');

-- Display employees who are joined in 1987
SELECT *
FROM employees
WHERE YEAR(hire_date) = '1987';

-- Display employees who are joined in June
SELECT *
FROM employees
WHERE MONTH(hire_date) = '6';

SELECT *
FROM employees
WHERE MONTHNAME(hire_date) = 'June';

-- Aggregrate Functions
SELECT AVG(salary)
FROM employees;

SELECT SUM(salary)
FROM employees;

SELECT MIN(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT COUNT(*)
FROM employees;
