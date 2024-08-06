-- Before Update
-- Table Creation
CREATE TABLE Sales (
	id INT AUTO_INCREMENT,
	product VARCHAR(100) NOT NULL,
	quantity INT NOT NULL DEFAULT 0,
	fiscalYear SMALLINT NOT NULL,
	fiscalMonth TINYINT NOT NULL,
	CHECK (fiscalMonth >= 1 AND fiscalMonth <= 12),
	CHECK (fiscalYear BETWEEN 2000 AND 2050),
	CHECK (quantity >= 0),
	UNIQUE (product, fiscalYear, fiscalMonth),
	PRIMARY KEY (id) 
);

INSERT INTO Sales (product, quantity, fiscalYear, fiscalMonth)
VALUES ('2003 Harley-Davidson Eagle Drag Bike', 120, 2020, 1),
 ('1969 Corvair Monza', 150, 2020, 1),
 ('1970 Plymouth Hemi Cuda', 200, 2020, 1);

SELECT *
FROM Sales;

-- Creating Trigger
DELIMITER //

CREATE TRIGGER BeforeSalesUpdate
BEFORE UPDATE ON Sales
FOR EACH ROW
BEGIN
	DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ', NEW.quantity, ' cannot be 3 times greater than the current quantity ', OLD.quantity);
    
    IF NEW.quantity > OLD.quantity * 3 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = errorMessage;
	END IF;
END //

DELIMITER ;

SHOW TRIGGERS;

-- Current quantity 
SELECT *
FROM Sales;

-- Testing Trigger
UPDATE Sales
SET quantity = 150 
WHERE id = 1;

-- Will raise error because quantity greater 3 times 
UPDATE Sales
SET quantity = 500 
WHERE id = 1;

-- After Update
-- Table Creation
CREATE TABLE SalesChanges (
	id INT AUTO_INCREMENT PRIMARY KEY,
	salesId INT,
	beforeQuantity INT,
	afterQuantity INT,
	changeAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP	 
);

SELECT *
FROM SalesChanges;

-- Create Trigger
DELIMITER //

CREATE TRIGGER AfterSalesUpdate
AFTER UPDATE ON Sales
FOR EACH ROW
BEGIN
	-- OLD.quantity not equals NEW.quantity
	IF OLD.quantity <> NEW.quantity THEN
		INSERT INTO SalesChanges (salesId, beforeQuantity, afterQuantity)
        VALUES (OLD.id, OLD.quantity, NEW.quantity);
	END IF;
END //

DELIMITER ;

SHOW TRIGGERS;

-- Testing Trigger
UPDATE Sales
SET quantity = 350 
WHERE id = 1;

SELECT *
FROM SalesChanges;

UPDATE Sales
SET quantity = CAST(quantity * 1.1 AS UNSIGNED);

SELECT *
FROM SalesChanges;