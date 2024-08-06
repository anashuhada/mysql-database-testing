-- Set DELIMITER
DELIMITER //

-- Create stored procedure; input param
CREATE PROCEDURE SelectAllCustomersByCity(IN my_city VARCHAR(50))
BEGIN
	SELECT * 
    FROM customers
    WHERE city = my_city;
END //

DELIMITER ;

-- Call stored procedure; pass value
CALL SelectAllCustomersByCity('Singapore');