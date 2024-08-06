-- Transaction Control Languange: Commit & Rollback

USE mysql_tutorial;

SET autocommit = 0; -- Disable

DROP TABLE IF EXISTS student;

CREATE TABLE student (
	student_id INT(3),
    student_name VARCHAR(15)
);

INSERT INTO student VALUES (101, 'abc');
INSERT INTO student VALUES (102, 'def');
INSERT INTO student VALUES (103, 'ghi');

COMMIT;

SELECT *
FROM student;

SET SQL_SAFE_UPDATES = 0;

-- Remove records temporarily
DELETE FROM student
WHERE student_id = 103;

ROLLBACK; -- DELETE can be used ROLLBACK to get back the deleted data

-- After use INSERT, UPDATE, DELETE
COMMIT; -- After delete the use COMMIT; it's like SAVED what we've done, permanent changes

-- After COMMIT use ROLLBACK, the data is saved permanently
ROLLBACK; -- Won't get back the date because have used COMMIT

SELECT *
FROM student; -- ERROR