package StoredProcedureTesting;

import java.sql.*;
import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class AutomateSQLStoredProcedure {
	
	// Initialize
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs; // normal query
	CallableStatement cStmt; // call stored procedure
	ResultSet rs1;
	ResultSet rs2;
	
	// Create a connection
	@BeforeClass
	void setup () throws SQLException {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/classicmodels", "root", "password");
	}
	
	// Close the connection
	@AfterClass
	void tearDown() throws SQLException {
		conn.close();
	}
	
	// Check to pass the test method
	@Test(priority = 1)
	void testStoredProcedureExists() throws SQLException {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SHOW PROCEDURE STATUS WHERE Name = 'SelectAllCustomers'");
		rs.next(); // pointing to the current record
		Assert.assertEquals(rs.getString("Name"), "SelectAllCustomers");
	}
	
	// Java utility for comparing 2 result sets
		public boolean compareResultSets(ResultSet resultSet1, ResultSet resultSet2) throws SQLException {
			while(resultSet1.next()) {
				resultSet2.next();
				// Total no of columns in ResultSet
				int count = resultSet1.getMetaData().getColumnCount();
				for (int i = 1; i <= count; i++) {
					if (!StringUtils.equals(resultSet1.getString(i), resultSet2.getString(i))) {
						// Not matches return false
						return false;
					}
				}
			}
			
			return true;
		}
		
	// Accept no parameters and return no value
	// { call procedure_name() }
	
	// Accept two parameters and return no value
	// { call procedure_name(?,?) }

	// Accept no parameters and return value
	// {?= call procedure_name() }

	// Accept one parameter and return no value
	// {?= call procedure_name(?) }

	// Stored procedure SelectAllCustomers()
	@Test(priority = 2)
	void testSelectAllCustomers() throws SQLException {
		// Call the stored procedure
		cStmt = conn.prepareCall("{CALL SelectAllCustomers()}");
		rs1 = cStmt.executeQuery();
		
		// Normal query statement
		Statement stmt = conn.createStatement();
		rs2 = stmt.executeQuery("SELECT * FROM customers");
		
		// Return same values between stored procedure and normal query statement
		Assert.assertEquals(compareResultSets(rs1, rs2), true);
	}
	
	// Stored procedure SelectAllCustomersByCity()
	@Test(priority = 3)
	void testSelectAllCustomersByCity() throws SQLException {
		// Call the stored procedure
		cStmt = conn.prepareCall("{CALL SelectAllCustomersByCity(?)}");
		
		// Set input parameter
		cStmt.setString(1, "Singapore");
		
		// Execute stored procedure call
		rs1 = cStmt.executeQuery();
		
		// Normal query statement
		Statement stmt = conn.createStatement();
		rs2 = stmt.executeQuery("SELECT * FROM customers WHERE city = 'Singapore'");
		
		// Return same values between stored procedure and normal query statement
		Assert.assertEquals(compareResultSets(rs1, rs2), true);
	}
	
	// Stored procedure SelectAllCustomersByCityAndPin()
	@Test(priority = 4)
	void testSelectAllCustomersByCityAndPin() throws SQLException {
		// Call the stored procedure
		cStmt = conn.prepareCall("{CALL SelectAllCustomersByCityAndPin(?,?)}");
			
		// Set input parameter
		cStmt.setString(1, "Nantes"); // First input parameter
		cStmt.setString(2, "44000"); // Second input parameter
			
		// Execute stored procedure call
		rs1 = cStmt.executeQuery();
			
		// Normal query statement
		Statement stmt = conn.createStatement();
		rs2 = stmt.executeQuery("SELECT * FROM customers WHERE city = 'Nantes' AND postalCode = '44000'");
			
		// Return same values between stored procedure and normal query statement
		Assert.assertEquals(compareResultSets(rs1, rs2), true);
	}
		
	// Stored procedure GetOrderByCustomers()
	@Test(priority = 5)
	void testGetOrderByCustomers() throws SQLException {
		// Call the stored procedure
		cStmt = conn.prepareCall("{CALL GetOrderByCustomers(?,?,?,?,?)}");
					
		// Set input parameter
		cStmt.setInt(1, 141); // First input parameter
		
		// Register output parameter
		cStmt.registerOutParameter(2, Types.INTEGER); // Register first output parameter
		cStmt.registerOutParameter(3, Types.INTEGER); // Register second output parameter
		cStmt.registerOutParameter(4, Types.INTEGER); // Register third output parameter
		cStmt.registerOutParameter(5, Types.INTEGER); // Register fourth output parameter
		
		// Execute call stored procedure
		cStmt.executeQuery();
		
		// These values coming from call stored procedure
		int shipped = cStmt.getInt(2); // Get first output parameter
		int canceled = cStmt.getInt(3); // Get second output parameter
		int resolved = cStmt.getInt(4); // Get third output parameter
		int disputed = cStmt.getInt(5); // Get fourth output parameter
		
		//System.out.println(shipped + " " + canceled + " " + resolved + " " + disputed);
		
		// Normal query statement
		Statement stmt = conn.createStatement();
		
		// Return result set
		rs = stmt.executeQuery("SELECT (SELECT COUNT(*) AS 'shipped' FROM orders WHERE customerNumber = 141 AND status = 'Shipped') AS Shipped, (SELECT COUNT(*) AS 'canceled' FROM orders WHERE customerNumber = 141 AND status = 'Canceled') AS Canceled, (SELECT COUNT(*) AS 'resolved' FROM orders WHERE customerNumber = 141 AND status = 'Resolved') AS Resolved, (SELECT COUNT(*) AS 'disputed' FROM orders WHERE customerNumber = 141 AND status = 'Disputed') AS Disputed");
		
		// These values coming from normal query statement
		rs.next();
		int exp_shipped = rs.getInt("shipped");
		int exp_canceled = rs.getInt("canceled");
		int exp_resolved = rs.getInt("resolved");
		int exp_disputed = rs.getInt("disputed");
		
		// Return same values between stored procedure and normal query statement
		if (shipped == exp_shipped && canceled == exp_canceled && resolved == exp_resolved && disputed == exp_disputed) {
			Assert.assertTrue(true);
		}
		
		else {
			Assert.assertTrue(false);
		}
					
	}
	
	// Stored procedure GetCustomersShipping()
	@Test(priority = 6)
	void testGetCustomersShipping() throws SQLException {
		// Call the stored procedure
		cStmt = conn.prepareCall("{CALL GetCustomersShipping(?,?)}");
						
		// Set input parameter
		cStmt.setInt(1, 112); // First input parameter
			
		// Register output parameter
		cStmt.registerOutParameter(2, Types.VARCHAR); // Register first output parameter
			
		// Execute call stored procedure
		cStmt.executeQuery();
			
		// These values coming from call stored procedure
		String shipping_time = cStmt.getString(2); // Get first output parameter
			
		// Normal query statement
		Statement stmt = conn.createStatement();
			
		// Return result set
		rs = stmt.executeQuery("SELECT country, CASE WHEN country = 'USA' THEN '2-day Shipping' WHEN country = 'Canada' THEN '3-day Shipping' ELSE '5-day Shipping' END AS ShippingTime FROM customers WHERE customerNumber = 112");
			
		// These values coming from normal query statement
		rs.next();
		String exp_shippingTime = rs.getString("ShippingTime");
		
		// Compare values between stored procedure and normal query statement
		Assert.assertEquals(shipping_time, exp_shippingTime);
						
	}
	
}
