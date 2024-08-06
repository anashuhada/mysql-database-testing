-- Before Insert
-- Tables Creation
DROP TABLE IF EXISTS WorkCenters;
DROP TABLE IF EXISTS WorkCenterStats;

CREATE TABLE WorkCenters (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	capacity INT NOT NULL
);

CREATE TABLE WorkCenterStats (
	totalCapacity INT NOT NULL
);

-- Creating Trigger
DELIMITER //

CREATE TRIGGER BeforeWorkCentersInsert
BEFORE INSERT ON WorkCenters
FOR EACH ROW
BEGIN 
	DECLARE rowCount INT; -- local variable
    
    -- Starting; there's no data, which is 0
    SELECT COUNT(*)
    INTO rowCount
    FROM WorkCenterStats;
    
    -- If the rowCount > 0 means there's record in the WorkCenterStats
    IF rowCount > 0 THEN 
		UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + NEW.capacity; -- value new.capacity will be received from WorkCenters
	ELSE 
		INSERT INTO WorkCenterStats(totalCapacity) VALUES (NEW.capacity); -- will hold only one record
	END IF;
END //

DELIMITER ;

DESCRIBE WorkCenters;
DESCRIBE WorkCenterStats;

SHOW TRIGGERS;

-- Testing Trigger
-- Currently there's no totalCapacity
SELECT *
FROM WorkCenterStats;

-- Insert a new row in WorkCenters table
-- Trigger will capture the capacity value and will be adding into totalCapacity since there's no record yet
INSERT INTO WorkCenters (name, capacity) VALUES ('Mold Machine', 100);

SELECT *
FROM WorkCenters;

-- Query data from the WorkCenterStats table
SELECT *
FROM WorkCenterStats;

SET SQL_SAFE_UPDATES = 0;

-- Insert a new work center
INSERT INTO WorkCenters (name, capacity) VALUES ('Packing', 200);

-- Finally query data from the WorkCenterStats table
SELECT *
FROM WorkCenterStats;

-- After Insert
-- Table Creation
CREATE TABLE Members (
	id INT AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(255),
	birthDate DATE,
	PRIMARY KEY (id)
);

CREATE TABLE Reminders (
	id INT AUTO_INCREMENT,
	memberId INT,
	message VARCHAR(255) NOT NULL,
	PRIMARY KEY (id, memberId)
);

-- Creating Trigger
DELIMITER //

CREATE TRIGGER AfterMembersInsert
AFTER INSERT ON Members
FOR EACH ROW
BEGIN
	-- Only if birthDate IS NULL
	IF NEW.birthDate IS NULL THEN INSERT INTO Reminders (memberId, message)
		VALUES (NEW.id, CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END //

DELIMITER ;

SHOW TRIGGERS;

-- Testing Trigger
INSERT INTO Members (name, email, birthDate) VALUES ('John', 'john@example.com', NULL);
INSERT INTO Members (name, email, birthDate) VALUES ('Kim', 'kim@example.com', '2012-05-01');
INSERT INTO Members (name, email, birthDate) VALUES ('Sarah', 'sarah@example.com', NULL);

SELECT *
FROM Members;

SELECT *
FROM Reminders;