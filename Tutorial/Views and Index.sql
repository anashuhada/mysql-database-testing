-- VIEWS
-- A virtual table based on the result-set of SQL statement
-- Contains rows and columns, just like a real table
-- The fields in a VIEW are fields from one or more real tables in DB
-- Can add SQL functions, WHERE and JOIN statements to a VIEW and present the data as if the data were coming from one single table

USE hr;

SELECT *
FROM employees;

-- Create a query
SELECT employee_id, first_name, salary
FROM employees; 

-- Create a VIEW
CREATE VIEW view_employees
AS
	SELECT employee_id, first_name, salary
	FROM employees; 
    
SELECT * 
FROM view_employees;

-- Remove a VIEW
DROP VIEW view_employees;

-- INDEX
-- Used to retrieve data from DB very fast
-- The users cannot see the indexes, just used to speed up searches/queries

-- Create INDEX
CREATE INDEX index_employees
ON employees (first_name);

SHOW INDEXES FROM employees;

-- Remove INDEX
DROP INDEX index_employees
ON employees;