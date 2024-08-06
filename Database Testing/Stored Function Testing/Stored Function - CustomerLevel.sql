USE classicmodels;

-- Set DELIMITER
DELIMITER // 

-- Create Stored Function
CREATE FUNCTION CustomerLevel(credit DECIMAL(10,2)) RETURNS VARCHAR(20)
DETERMINISTIC -- always returns the same results if given the same input values
BEGIN
	DECLARE customerLevel VARCHAR(20); -- declare global variable
    IF (credit > 50000) THEN
		SET customerLevel = 'PLATINUM';
	ELSEIF (credit >= 10000 AND credit <= 50000) THEN
		SET customerLevel = 'GOLD';
	ELSEIF (credit < 10000) THEN
		SET customerLevel = 'SILVER';
	END IF;
    RETURN customerLevel;
END //

DELIMITER ;

SHOW FUNCTION STATUS WHERE db = 'classicmodels';

-- Call Stored Function
SELECT customerName, CustomerLevel(creditLimit)
FROM customers;

-- Create Stored Procedure to be called in Stored Function
DELIMITER //

CREATE PROCEDURE GetCustomerLevel(
	IN customerNo INT,
    OUT customerLevel VARCHAR(20)
)
BEGIN
	DECLARE credit DEC(10,2) DEFAULT 0; -- local variable
    
    -- Get credit limit from customer table to be returned in credit
    SELECT creditLimit
    INTO credit 
    FROM customers
    WHERE customerNumber = customerNo;
    
    -- Call stored function
    SET customerLevel = CustomerLevel(credit);
END //

DELIMITER ; 

-- Call Stored Procedure through Stored Function
CALL GetCustomerLevel(131, @customerLevel);
SELECT @customerLevel;
