-- Group By, Having, Order By Clauses in SQL

-- GROUP BY
SELECT department_id, SUM(salary)
FROM employees 
GROUP BY department_id;

SELECT department_id, AVG(salary)
FROM employees 
GROUP BY department_id;

SELECT department_id, MAX(salary), MIN(salary)
FROM employees 
GROUP BY department_id;

SELECT job_id, COUNT(*)
FROM employees 
GROUP BY job_id;

-- All the columns in the select list should include in GROUP BY clause
SELECT department_id, job_id, SUM(salary)
FROM employees 
GROUP BY department_id, job_id;

SELECT department_id, SUM(salary), first_name
FROM employees 
GROUP BY department_id, first_name;

SELECT department_id, job_id, COUNT(*)
FROM employees 
GROUP BY department_id, job_id;

-- HAVING
SELECT job_id, COUNT(*)
FROM employees 
GROUP BY job_id
HAVING COUNT(*) > 2;

SELECT department_id, SUM(salary)
FROM employees 
GROUP BY department_id
HAVING SUM(salary) > 2000;

SELECT department_id, SUM(salary) sal
FROM employees 
WHERE department_id <> 5
GROUP BY department_id
HAVING sal > 5000;

-- ORDER BY
SELECT *
FROM employees 
ORDER BY department_id ASC;

-- Order of Execution
SELECT department_id, SUM(salary)
FROM employees 
GROUP BY department_id
HAVING SUM(salary) > 5000
ORDER BY SUM(salary);

SELECT department_id, SUM(salary)
FROM employees 
WHERE department_id <> 5
GROUP BY department_id
HAVING SUM(salary) > 5000
ORDER BY SUM(salary) DESC;