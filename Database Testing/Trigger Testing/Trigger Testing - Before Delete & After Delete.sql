-- Before Delete
-- Table Creation
CREATE TABLE Salaries (
	employeeNumber INT PRIMARY KEY,
	validForm DATE NOT NULL,
	salary DECIMAL(12,2) NOT NULL DEFAULT 0
);

INSERT INTO Salaries (employeeNumber, validForm, salary)
VALUES
(1002, '2000-01-01', 50000),
(1056, '2000-01-01', 60000),
(1076, '2000-01-01', 70000);

SELECT *
FROM Salaries;

CREATE TABLE SalaryArchives (
	 id INT PRIMARY KEY AUTO_INCREMENT,
	 employeeNumber INT,
	validForm DATE NOT NULL,
	salary DECIMAL(12,2) NOT NULL DEFAULT 0,
	deletedAt TIMESTAMP DEFAULT NOW()
);

-- Create Trigger
DELIMITER //

CREATE TRIGGER BeforeSalariesDelete
BEFORE DELETE ON Salaries
FOR EACH ROW
BEGIN 
	INSERT INTO SalaryArchives (employeeNumber, validForm, salary)
	VALUES (OLD.employeeNumber, OLD.validForm, OLD.salary);
END //

DELIMITER ;

SHOW TRIGGERS;

-- Testing Trigger
DELETE FROM Salaries
WHERE employeeNumber = 1002;

SELECT *
FROM SalaryArchives;

DELETE FROM Salaries;

SELECT *
FROM SalaryArchives;

-- After Delete
-- Table Creation
DROP TABLE IF EXISTS Salaries;
CREATE TABLE Salaries (
	 employeeNumber INT PRIMARY KEY,
	validForm DATE NOT NULL,
	salary DECIMAL(12,2) NOT NULL DEFAULT 0
);

INSERT INTO Salaries (employeeNumber, validForm, salary)
VALUES
(1002, '2000-01-01', 50000),
(1056, '2000-01-01', 60000),
(1076, '2000-01-01', 70000);

CREATE TABLE SalaryBudgets (
	total DECIMAL(15, 2) NOT NULL
);

INSERT INTO SalaryBudgets (total) SELECT SUM(salary) FROM Salaries;

SELECT *
FROM SalaryBudgets;

-- Create Trigger
DELIMITER //

CREATE TRIGGER AfterSalariesDelete 
AFTER DELETE ON Salaries 
FOR EACH ROW
BEGIN
	UPDATE SalaryBudgets SET total = total - OLD.salary;
END //

DELIMITER ; 

SELECT *
FROM Salaries; -- 3 records

SELECT *
FROM SalaryBudgets; -- 180000.00

-- Testing Trigger
DELETE FROM Salaries
WHERE employeeNumber = 1002;

DELETE FROM Salaries; -- delete all salary

SELECT *
FROM SalaryBudgets;