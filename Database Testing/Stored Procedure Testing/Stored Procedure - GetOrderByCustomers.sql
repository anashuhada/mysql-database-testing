-- Set DELIMITER
DELIMITER //

-- Create stored procedure: IN = input, OUT = output
CREATE PROCEDURE GetOrderByCustomers(
	IN customer_no INT,
    OUT shipped INT,
    OUT canceled INT,
    OUT resolved INT,
    OUT disputed INT)
BEGIN
	-- Shipped
    SELECT COUNT(*) INTO shipped
    FROM orders
    WHERE customerNumber = customer_no
    AND status = 'Shipped';
    
    -- Canceled
    SELECT COUNT(*) INTO canceled
    FROM orders
    WHERE customerNumber = customer_no
    AND status = 'Canceled';
    
    -- Resolved
    SELECT COUNT(*) INTO resolved
    FROM orders
    WHERE customerNumber = customer_no
    AND status = 'Resolved';
    
    -- Disputed
    SELECT COUNT(*) INTO disputed
    FROM orders
    WHERE customerNumber = customer_no
    AND status = 'Disputed';
    
END //

DELIMITER ;

CALL GetOrderByCustomers(141, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;