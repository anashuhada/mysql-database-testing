-- Data Definition Language (DDL) Commands

USE mysql_tutorial;

-- Remove student table
DROP TABLE student_new;

CREATE TABLE student_new (
	student_id INT(5),
    student_name VARCHAR(30)
);

DESCRIBE student_new;

INSERT INTO student_new VALUES(101, 'David');
INSERT INTO student_new VALUES(102, 'Smith');
INSERT INTO student_new VALUES(103, 'Scott');

COMMIT;

SELECT *
FROM student_new;

-- ALTER ADD a new column
ALTER TABLE student_new ADD(
	grade VARCHAR(2)
);

-- ALTER DROP a column
ALTER TABLE student_new DROP COLUMN grade;

-- ALTER MODIFY a column; modify data type
ALTER TABLE student_new MODIFY COLUMN student_name VARCHAR(50);

-- ALTER RENAME a column
ALTER TABLE student_new RENAME COLUMN student_name TO stud_name;

-- COMMIT used after INSERT/UPDATE/DELETE; data modifications are committed and made permanent
SET autocommit = 0; -- not automatically committed after they are executed

SET SQL_SAFE_UPDATES = 0;

SELECT *
FROM student_new;

-- DELETE
DELETE FROM student_new;

COMMIT; -- even use ROLLBACK data won't be getting back; commit changes permanently

-- Get back the data 
ROLLBACK;

-- Populate new data for TRUNCATE purposes
INSERT INTO student_new VALUES(101, 'David');
INSERT INTO student_new VALUES(102, 'Smith');
INSERT INTO student_new VALUES(103, 'Scott');

COMMIT;

-- TRUNCATE; remove permanently, cannot get back the data
TRUNCATE TABLE student_new;

-- DROP; remove completely
DROP TABLE student_new;

CREATE TABLE student_new (
	stud_id INT(5),
    stud_name VARCHAR(30)
);

-- RENAME TABLE
RENAME TABLE student_new TO stud_new;


