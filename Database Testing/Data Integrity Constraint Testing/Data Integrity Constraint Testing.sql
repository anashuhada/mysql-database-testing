USE classicmodels;

-- Table Creation
CREATE TABLE course (
	course_id INT(2) PRIMARY KEY,
	course_name VARCHAR(20) UNIQUE,
	duration INT(2),	
	fee	INT(3) CHECK(fee BETWEEN 100 AND 500)
);

SELECT *
FROM course;

-- Testing Constraints
-- Validate course_id
INSERT INTO course VALUES (111, 'Java', 3, 500); -- success, valid
INSERT INTO course VALUES (111, 'Python', 2, 300); -- fail, invalid course_id is PK
INSERT INTO course VALUES (NULL, 'Python', 2, 300); -- fail, invalid course_id is cannot be NULL

-- Validate course_name
INSERT INTO course VALUES (222, 'Python', 2, 300); -- success, valid
INSERT INTO course VALUES (333, 'Python', 2, 300); -- fail, invalid duplicated course_name

-- Validate fee
INSERT INTO course VALUES (333, 'JavaScript', 1, 100); -- success, valid
INSERT INTO course VALUES (444, 'TypeScript', 1, 500); -- success, valid
INSERT INTO course VALUES (555, 'VBScript', 1, 50); -- fail, invalid fee must BETWEEN 100-500
INSERT INTO course VALUES (555, 'VBScript', 1, 600); -- fail, invalid fee must BETWEEN 100-500

CREATE TABLE student (
	student_id INT(5) PRIMARY KEY,
	student_name VARCHAR(20) NOT NULL,
	age	INT(2) CHECK(age BETWEEN 15 AND 30),
	date_of_joined	DATETIME DEFAULT NOW(),
	date_of_completion	DATETIME,
	course_id INT(2),
    FOREIGN KEY(course_id) REFERENCES course(course_id) ON DELETE CASCADE
);

SELECT *
FROM student;

-- Validate student_id and student_name
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (101, 'John', 20, NULL, 111); -- success, FK matched with PK in course table
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (101, 'X', 20, NULL, 111); -- fail, duplicated student_id 
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (102, NULL, 20, NULL, 111); -- fail, student_name cannot be NULL

-- Validate age
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (102, 'Smith', 15, NULL, 111); -- success, age valid in BETWEEN the range
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (103, 'Kim', 30, NULL, 111);  -- success, age valid in BETWEEN the range
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (104, 'Mary', 10, NULL, 111); -- fail, age invalid in BETWEEN the range
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (104, 'Mary', 35, NULL, 111); -- fail, age invalid in BETWEEN the range

-- Validate date_of_joined
SELECT date_of_joined
FROM student;

-- Validate course_id FOREIGN KEY (REFERENCES to course_id of course table)
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (104, 'Scott', 30, NULL, 222); -- success, valid FK
INSERT INTO student (student_id, student_name, age, date_of_completion, course_id)
VALUES (105, 'David', 20, NULL, 555); -- fail, invalid FK 

-- Delete record from parent table (course) and check child table (student) record automatically deleted
DELETE FROM course
WHERE course_id = 222;

SELECT *
FROM student;

