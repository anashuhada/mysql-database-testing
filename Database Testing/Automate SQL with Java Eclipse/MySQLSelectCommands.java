package mysql_tutorial;

//SELECT
//Create a connection
//Create a statement/query
//Execute a statement/query
//Store the results in result set
//Close the connection

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLSelectCommands {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		
		//Create a connection
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hr", "root", "password");
	
		//Create a statement/query
		Statement stmt = conn.createStatement();
		String select = "SELECT employee_id, first_name, salary FROM employees";
		
		//Execute a statement/query & store the results in result set
		ResultSet rs = stmt.executeQuery(select); // contain the data from DB
		
		while (rs.next()) {
			// column name in DB
			int emp_id = rs.getInt("employee_id");
			String name = rs.getString("first_name");
			String salary = rs.getString("salary");
			System.out.println(emp_id + " " + name + " " + salary);
		}
		
		//Close the connection
		conn.close();
		
	}

}
