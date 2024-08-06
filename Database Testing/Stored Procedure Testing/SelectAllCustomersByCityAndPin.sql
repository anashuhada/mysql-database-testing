-- Set DELIMITER
DELIMITER //

-- Create stored procedure: pass two params
CREATE PROCEDURE SelectAllCustomersByCityAndPin(
IN my_city VARCHAR(50),
IN pin_code VARCHAR(15)
)
BEGIN
	SELECT *
    FROM customers
    WHERE city = my_city
    AND postalCode = pin_code;
END //

DELIMITER ;

-- Call stored procedure: pass two values
CALL SelectAllCustomersByCityAndPin('Nantes', '44000');

