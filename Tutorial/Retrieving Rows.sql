-- Selecting rows from a table
USE hr;

-- Read/retrieve all columns
SELECT * 
FROM employees;

-- Read only the specified columns
SELECT employee_id, first_name, last_name, salary
FROM employees;

-- Use AS to rename column names
SELECT employee_id empID, first_name fName, last_name lName, salary Sal
FROM employees;

-- Salary increment + 5000
SELECT employee_id empID, first_name fName, last_name lName, salary + 5000 Sal
FROM employees;



