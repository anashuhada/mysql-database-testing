package StoredFunctionTesting;

import java.sql.*;

import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class AutomateSQLStoredFunction {

	Connection conn = null;
	Statement stmt;
	ResultSet rs;
	ResultSet rs1;
	ResultSet rs2;
	CallableStatement cStmt;
	
	@BeforeClass
	void setup() throws SQLException {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/classicmodels", "root", "upm_1620");
	}
	
	@AfterClass
	void tearDown() throws SQLException {
		conn.close();
	}
	
	@Test(priority = 1)
	void testStoredFunctionExist() throws SQLException {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SHOW FUNCTION STATUS WHERE Name = 'CustomerLevel'");
		
		rs.next(); // pointing out the current row/record
		
		String nameStoredProcedure = rs.getString("Name");
		
		Assert.assertEquals(nameStoredProcedure, "CustomerLevel");
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
	
	@Test(priority = 2)
	void testCustomerLevelWithSQLStatement() throws SQLException {
		// Comparing call stored function with normal query statement
		rs1 = conn.createStatement().executeQuery("SELECT customerName, CustomerLevel(creditLimit) FROM customers");
		rs2 = conn.createStatement().executeQuery("SELECT customerName, CASE WHEN creditLimit > 50000 THEN 'PLATINUM' WHEN creditLimit >= 10000 AND creditLimit < 50000 THEN 'GOLD' WHEN creditLimit < 10000 THEN 'SILVER' END AS customerLevel FROM customers");
		
		Assert.assertEquals(compareResultSets(rs1, rs2), true);
	}

	@Test(priority = 3)
	void testCustomerLevelWithStoredProcedure() throws SQLException {
		
		// Stored procedure
		cStmt = conn.prepareCall("{CALL GetCustomerLevel(?,?)}");
		
		// Set input parameter
		cStmt.setInt(1, 131);
		
		// Register output parameter
		cStmt.registerOutParameter(2, Types.VARCHAR);
		
		// Execute stored procedure
		cStmt.executeQuery();
		
		// Get output parameter
		String custLevel = cStmt.getString(2);
		
		// Normal query
		rs = conn.createStatement().executeQuery("SELECT customerName, CASE WHEN creditLimit > 50000 THEN 'PLATINUM' WHEN creditLimit >= 10000 AND creditLimit < 50000 THEN 'GOLD' WHEN creditLimit < 10000 THEN 'SILVER' END AS customerLevel FROM customers WHERE customerNumber = 131");
		rs.next();
		
		String exp_custlevel = rs.getString("customerLevel");
		
		Assert.assertEquals(custLevel, exp_custlevel);
	}
}
