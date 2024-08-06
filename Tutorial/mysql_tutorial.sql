-- CREATE DATABASE mysql_tutorial;

USE mysql_tutorial;

-- Create student table
CREATE TABLE student (
	student_no int(5),
    student_name varchar(30),
    marks int(10)
);

-- DESCRIBE: describe the overview of the table
DESCRIBE student;

-- Inserting data into student table
-- Method #1: columns not included
INSERT INTO student VALUES (101, 'Liam Henderson', 80);

-- Method #2: columns included
INSERT INTO student (student_no, student_name, marks) VALUES (102, 'Sophia Ramirez', 60);

-- Add NULL value
INSERT INTO student VALUES (103, 'Ethan Mitchell', NULL);

SELECT * FROM student;

-- Look for null marks
SELECT * 
FROM student
WHERE marks IS NULL;

-- UNION & UNION ALL Operator
CREATE TABLE A (
	student_name VARCHAR(10),
    num INT(2)
);

INSERT INTO A VALUES ('ABC', 10);
INSERT INTO A VALUES ('XYZ', 11);
INSERT INTO A VALUES ('PQR', 12);
INSERT INTO A VALUES ('MNO', 14);

COMMIT;

CREATE TABLE B (
    num INT(2),
    grade VARCHAR(3)
);

INSERT INTO B VALUES (11, 'A');
INSERT INTO B VALUES (12, 'B');
INSERT INTO B VALUES (13, 'C');
INSERT INTO B VALUES (15, 'B');

COMMIT;

-- Display all the records from multiple tables without duplicates
SELECT num
FROM A
UNION
SELECT num
FROM B;

-- Display all the records from multiple tables including duplicates
SELECT num
FROM A
UNION ALL
SELECT num
FROM B;


