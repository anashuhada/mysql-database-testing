-- SQL Joins and Sub Queries
USE mysql_tutorial;

CREATE TABLE table_one (
	num_id INT(3)
);

INSERT INTO table_one VALUES (10);
INSERT INTO table_one VALUES (11);
INSERT INTO table_one VALUES (12);
INSERT INTO table_one VALUES (14);

CREATE TABLE table_two (
	num_id INT(3)
);

INSERT INTO table_two VALUES (11);
INSERT INTO table_two VALUES (12);
INSERT INTO table_two VALUES (13);
INSERT INTO table_two VALUES (15);

SELECT * 
FROM table_one;

SELECT * 
FROM table_two;

-- Inner Join: returns only matched records from both tables
SELECT *
FROM table_one
INNER JOIN table_two
ON table_one.num_id = table_two.num_id;

-- Right Join: returns matched records & unmatched from table_one
SELECT *
FROM table_one
RIGHT JOIN table_two
ON table_one.num_id = table_two.num_id;

-- Left Join: returns matched records & unmatched from table_two
SELECT *
FROM table_one
LEFT JOIN table_two
ON table_one.num_id = table_two.num_id;

-- Full Outer Join: returns matched records & unmatched from both tables
-- Not supported in MySQL
SELECT *
FROM table_one
FULL JOIN table_two
ON table_one.num_id = table_two.num_id;
