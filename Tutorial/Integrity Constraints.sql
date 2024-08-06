-- Integrity Constraints
USE mysql_tutorial;

-- NOT NULL
CREATE TABLE student (
	student_no INT(3) NOT NULL,
    student_name VARCHAR(10),
    marks INT(3)
);

INSERT INTO student VALUES (101, 'Ayla', 50);
INSERT INTO student VALUES (NULL, 'Steve', 70); -- ERROR because NULL value not allowed

SELECT *
FROM student;

-- UNIQUE: can apply both column and table level
DROP TABLE IF EXISTS student;

-- Column level 
CREATE TABLE student (
	student_no INT(3) UNIQUE,
    student_name VARCHAR(10),
    marks INT(3)
);

-- Table level 
CREATE TABLE student (
	student_no INT(3),
    student_name VARCHAR(10),
    marks INT(3),
    UNIQUE(student_no)
);

INSERT INTO student VALUES (101, 'Ayla', 50);

SELECT *
FROM student;

INSERT INTO student VALUES (101, 'Steve', 70); -- same value not allowed
INSERT INTO student VALUES (NULL, 'Ellen', 90);
INSERT INTO student VALUES (NULL, 'David', 60); 

-- PRIMARY: combination of UNIQUE + NOT NULL
-- Not allow duplicate and null values
-- Can create both column and table level
DROP TABLE IF EXISTS student;

-- Column level 
CREATE TABLE student (
	student_no INT(3) PRIMARY KEY,
    student_name VARCHAR(10),
    marks INT(3)
);

INSERT INTO student VALUES (101, 'Steve', 70); 
INSERT INTO student VALUES (101, 'Ellen', 90); -- duplicate value not allowed
INSERT INTO student VALUES (NULL, 'David', 60); -- null value not allowed

-- Table level 
CREATE TABLE student (
	student_no INT(3),
    student_name VARCHAR(10),
    marks INT(3),
    PRIMARY KEY(student_no)
);

-- Can create PK on combination of 2 columns called as composite primary key
-- Composite key can be applied only at table level
DROP TABLE IF EXISTS student;
-- Table level 
CREATE TABLE student (
	student_no INT(3),
    class int(3),
    student_name VARCHAR(10),
    marks INT(3),
    PRIMARY KEY(student_no, class)
);

-- FOREIGN KEY: a key used to link 2 tables together
-- A field or collection of fields in one table that refers to the PRIMARY KEY in another table
-- Table that contains the FK is called as child table, the table that contains the candidate key is called the referenced/parent table

-- Parent table
CREATE TABLE school (
	stud_no INT(3),
    stud_name VARCHAR(15),
    marks INT(3),
    PRIMARY KEY(stud_no)
);

INSERT INTO school VALUES (101, 'Steve', 100);
INSERT INTO school VALUES (102, 'Sarah', 50);
INSERT INTO school VALUES (103, 'Adam', 70);

SELECT *
FROM school;

-- Child table
CREATE TABLE library (
	stud_no INT(3),
    book_name VARCHAR(10),
    FOREIGN KEY(stud_no) REFERENCES school(stud_no)
);

INSERT INTO library VALUES (102, 'Java');
INSERT INTO library VALUES (108, 'C#'); -- invalid, value must match with parent table
INSERT INTO library VALUES (NULL, '.net'); -- valid, only refer to parent table

SELECT *
FROM library;

-- Can remove the data from child table before removing data from parent table
-- Child table
DELETE FROM library 
WHERE stud_no = 102;

-- Parent table
DELETE FROM school 
WHERE stud_no = 102;

-- When inserting a record into child table, the column will be referred in parent table
-- If try removing parent table record directly without deleting records from child table -> it's not allowed
-- First, delete dependent record from child table, then delete record from parent table

-- ON DELETE CASCADE
-- Normally, we cannot delete rows from parent table unless we delete the corresponding row from child table
-- We can delete the rows from the parent table & corresponding child table row as well (at the same time) by using ONDELETECASCADE option
-- If deleting record from parent table directly, it will be removed and corresping records will be also deleted from child table

DROP TABLE IF EXISTS library;
DROP TABLE IF EXISTS school;

-- Parent table
CREATE TABLE school (
	stud_no INT(3),
    stud_name VARCHAR(15),
    marks INT(3),
    PRIMARY KEY(stud_no)
);

INSERT INTO school VALUES (101, 'Steve', 100);
INSERT INTO school VALUES (102, 'Sarah', 50);
INSERT INTO school VALUES (103, 'Adam', 70);

SELECT *
FROM school;

-- Child table
CREATE TABLE library (
	stud_no INT(3),
    FOREIGN KEY(stud_no) REFERENCES school(stud_no) ON DELETE CASCADE,
    book_name VARCHAR(10)
);

INSERT INTO library VALUES (101, 'Java');
INSERT INTO library VALUES (102, 'C#');

SELECT *
FROM library;

SELECT *
FROM school;

DELETE FROM school
WHERE stud_no = 103; -- successfully deleted directly from parent table

DROP TABLE library;

-- CHECK: used for allowing to user to enter specific values into column
DROP TABLE IF EXISTS school;
CREATE TABLE school (
	stud_no INT(3),
    stud_name VARCHAR(15),
    marks INT(3) CHECK(marks BETWEEN 50 AND 100)
);

INSERT INTO school VALUES (101, 'Steve', 60); -- valid
INSERT INTO school VALUES (101, 'Steve', 49); -- invalid
INSERT INTO school VALUES (101, 'Steve', 101); -- invalid

CREATE TABLE location (
	city VARCHAR(15) CHECK(city IN ('Las Cruces', 'Rio Rancho', 'Santa Fe')),
    country VARCHAR(15),
    pin INT(8)
);

INSERT INTO location VALUES ('Las Cruces', 'Mexico', 123456); -- valid
INSERT INTO location VALUES ('Roswell', 'Mexico', 789101); -- invalid
INSERT INTO location VALUES ('Santa Fe', 'Mexico', 987654); -- valid

-- DEFAULT: to provide a default value for a column
-- The default value will be added to all new records IF NO OTHER VALUES IS SPECIFIED

CREATE TABLE orders (
	id INT(5),
    order_number INT(5),
    order_date DATETIME DEFAULT NOW()
);

INSERT INTO orders VALUES (101, 12345, '2024-07-30 15:43:40'); -- insert manually
INSERT INTO orders VALUES (102, 54321, '2024-07-30 15:43:40'); -- insert manually
INSERT INTO orders (id, order_number) VALUES (103, 456789); -- order_date will be added auto

SELECT *
FROM orders;

SELECT NOW();