-- Multi Row Sub Queries
-- Display employees whose salary is equal to the salary of the at least one employee in department id 3
SELECT salary 
FROM employees
WHERE department_id = 3;

SELECT *
FROM employees
WHERE salary IN (SELECT salary 
FROM employees
WHERE department_id = 3);

-- Display the employees whose salary is greater than the at least on employee in department id 3
SELECT salary 
FROM employees
WHERE department_id = 3;

SELECT *
FROM employees
WHERE salary > ANY (SELECT salary 
FROM employees
WHERE department_id = 3);

SELECT *
FROM employees
WHERE salary > ALL (SELECT salary 
FROM employees
WHERE department_id = 3);

-- Display the employees whose salary is less than the at least on employee in department id 3
SELECT salary 
FROM employees
WHERE department_id = 3;

SELECT *
FROM employees
WHERE salary < ANY (SELECT salary 
FROM employees
WHERE department_id = 3);

-- Get department name of the employee
SELECT first_name, employee_id, department_id, (SELECT department_name
FROM  departments 
WHERE employees.department_id = departments.department_id) department_name
FROM  employees;

-- List out the employee who are having salary less than the maximum salary
-- and also having hire date greater than
-- the hire date of an employee who is having maximum salary
SELECT employee_id, first_name, salary, hire_date
FROM employees
WHERE salary <
(SELECT MAX(salary) FROM employees) 
	AND
    hire_date > (SELECT hire_date
	FROM employees
    WHERE salary = (SELECT MAX(salary) FROM employees));
