-- Display employees whose salary is less than the Steven's salary
-- Display Steven's salary first
SELECT salary
FROM employees
WHERE first_name = 'Steven'; -- 24000.00

-- Then, display all employees salary
SELECT salary
FROM employees
WHERE salary < 24000.00;

-- Use sub-query
SELECT first_name, salary
FROM employees
WHERE salary < (SELECT salary
FROM employees
WHERE first_name = 'Steven');
