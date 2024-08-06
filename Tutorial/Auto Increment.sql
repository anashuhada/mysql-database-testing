-- Auto Increment
-- A function that operates on NUMERIC data types
-- It automatically generates sequential numeric values every time that a record is inserted into a table for a field defined as auto increment

USE mysql_tutorial;

CREATE TABLE student_auto_increment (
	student_no INT(5) PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(15),
    marks INT(5)
);

INSERT INTO student_auto_increment (student_name, marks) VALUES ('X', 60); 
INSERT INTO student_auto_increment (student_name, marks) VALUES ('Y', 45); 
INSERT INTO student_auto_increment (student_name, marks) VALUES ('Z', 105);
INSERT INTO student_auto_increment (student_name, marks) VALUES ('A', 100);
INSERT INTO student_auto_increment (student_name, marks) VALUES ('B', 90);

SELECT *
FROM student_auto_increment;

-- Initialise
ALTER TABLE student_auto_increment AUTO_INCREMENT = 100;
