-- Inner Join/Self Join

USE hr;

SELECT *
FROM employees;

SELECT *
FROM departments;

-- Inner Join
SELECT *
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

SELECT first_name, salary, departments.department_id
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

-- Left Join
SELECT first_name, salary, departments.department_id
FROM employees
LEFT JOIN departments
ON employees.department_id = departments.department_id;

SELECT employee_id, first_name, job_id, dept.department_id, department_name, location_id
FROM employees emp
LEFT JOIN departments dept
ON emp.department_id = dept.department_id;

-- Right Join
SELECT first_name, salary, departments.department_id
FROM employees
RIGHT JOIN departments
ON employees.department_id = departments.department_id;

-- Self Join
SELECT emp.employee_id, emp.first_name, mgr.manager_id
FROM employees emp, employees mgr
WHERE emp.employee_id = mgr.manager_id;

SELECT emp.employee_id, emp.first_name, emp.job_id, mgr.manager_id, mgr.first_name
FROM employees emp, employees mgr
WHERE emp.employee_id = mgr.manager_id;



