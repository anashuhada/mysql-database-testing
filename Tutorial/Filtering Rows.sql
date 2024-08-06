-- Filtering rows using WHERE clause, Operators and Pattern Matching
-- WHERE clause: used for selecting the rows based on condition; filtering the rows where condition
-- salary greater than 15000
USE hr;

SELECT * 
FROM employees
WHERE salary > 15000;

-- salary less than and equal to 3000
SELECT * 
FROM employees
WHERE salary <= 3000;

-- department_id is 3
SELECT * 
FROM employees
WHERE department_id = 3;

-- Look for null manager_id
SELECT * 
FROM employees
WHERE manager_id IS NULL;

-- Look for first_name is Jennifer
SELECT * 
FROM employees
WHERE first_name = 'Jennifer';

-- Look for unduplicated/unique department_id column
SELECT DISTINCT department_id
FROM employees;

-- Look for unduplicated/unique for all columns
SELECT DISTINCT *
FROM employees;

-- Logical operators; AND, OR, NOT
SET SQL_SAFE_UPDATES = 0;

-- Both must be exact correct
SELECT *
FROM employees
WHERE salary > 1500 AND job_id = 13;

-- Either one must be valid
SELECT *
FROM employees
WHERE salary > 1500 OR job_id = 13;

-- Look for first_name NOT equals to David
SELECT *
FROM employees
WHERE NOT first_name = 'David';

-- BETWEEN operators: used to display the rows which is following in the range of values
-- Output same like using BETWEEN
SELECT *
FROM employees
WHERE salary >= 10000 AND salary <= 12000;

-- BETWEEN: range
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 12000;

-- NOT BETWEEN
SELECT *
FROM employees
WHERE salary NOT BETWEEN 10000 AND 12000;


-- IN operators: return rows when the values are matching in the list
-- Long writing method
SELECT *
FROM employees
WHERE salary = 3400 OR salary = 2500 OR salary = 3000;

-- IN: that's why use IN 
SELECT *
FROM employees
WHERE salary IN (3400, 2500, 3000);

-- NOT IN
SELECT *
FROM employees
WHERE salary NOT IN (3400, 2500, 3000);

-- Pattern matching operators; wild card characters
-- %: many characters
-- _: single character

-- Start with S
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- End with r
SELECT *
FROM employees
WHERE first_name LIKE '%r';

-- Start with J and end with r
SELECT *
FROM employees
WHERE first_name LIKE 'J%r';

-- Contain m
SELECT *
FROM employees
WHERE first_name LIKE '%m%';

-- Not start with S
SELECT *
FROM employees
WHERE first_name NOT LIKE 'S%';

-- Second last char contains e and the last char is free
SELECT *
FROM employees
WHERE first_name LIKE '%e_';

-- Names with only 3 characters
SELECT *
FROM employees
WHERE first_name LIKE '___';
