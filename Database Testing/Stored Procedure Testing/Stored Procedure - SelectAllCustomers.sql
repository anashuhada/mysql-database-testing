USE classicmodels;
-- Set delimiter
DELIMITER //
-- Create stored procedure
CREATE PROCEDURE SelectAllCustomers()
BEGIN 
	SELECT *
    FROM customers;
END //

DELIMITER ;

-- Call stored procedure
CALL SelectAllCustomers();
