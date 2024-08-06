-- LIMIT: display limited rows
USE hr;

-- Display row 1-5
SELECT * 
FROM employees
LIMIT 5;

-- Display row 5th until 10 rows
SELECT * 
FROM employees
LIMIT 5, 10;

