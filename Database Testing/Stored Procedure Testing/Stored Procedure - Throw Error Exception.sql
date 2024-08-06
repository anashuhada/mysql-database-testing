-- Throw Error Exception

DELIMITER //

CREATE PROCEDURE InsertSupplierProduct(
	IN inSupplierId INT,
    IN inProductId INT
)
BEGIN
	-- Exit if the duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062
    SELECT 'Duplicate keys error encountered' 
    Message;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    SELECT 'SQLException encoutered'
    Message;
    
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    SELECT 'SQLSTATE 23000'
    ErrorCode;
    
    -- Insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts (supplierId, productId) VALUES (inSupplierId, inProductId);
    
    -- Return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END //

DELIMITER ; 