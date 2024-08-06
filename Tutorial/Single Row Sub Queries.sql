-- Single Row Sub Queries
-- Display second max salary from employees table
-- Display MAX salary
SELECT MAX(salary)
FROM employees;

-- Second MAX salary
(SELECT MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary)
FROM employees));

-- Find the salary of employees whose is greater than the salary of employee whose employee_id 105
SELECT salary
FROM employees
WHERE employee_id = 105;

SELECT salary
FROM employees
WHERE salary > (SELECT salary
FROM employees
WHERE employee_id = 105);

-- Display the employees who all are earning the highest salary
SELECT MAX(salary)
FROM employees;

SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary)
FROM employees);