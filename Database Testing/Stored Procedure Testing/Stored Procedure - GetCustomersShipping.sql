-- Set DELIMITER
DELIMITER //

-- Create stored procedure
CREATE PROCEDURE GetCustomersShipping(
    IN customer_no INT,
    OUT shipping_time VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100); -- create local variable

    -- Get the country of the customer
    SELECT country 
    INTO customerCountry
    FROM customers
    WHERE customerNumber = customer_no;

    -- Determine shipping based on country
    CASE
        WHEN customerCountry = 'USA' THEN SET shipping_time = '2-day Shipping';
        WHEN customerCountry = 'Canada' THEN SET shipping_time = '3-day Shipping';
        ELSE SET shipping_time = '5-day Shipping';
    END CASE;

END //

DELIMITER ;

-- Call the stored procedure
CALL GetCustomersShipping(353, @shipping_time);

-- Retrieve the output value
SELECT @shipping_time;
