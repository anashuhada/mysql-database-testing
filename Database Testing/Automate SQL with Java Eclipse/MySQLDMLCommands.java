package mysql_tutorial;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

//DML: INSERT, UPDATE, DELETE
//Create a connection
//Create a statement/query
//Execute a statement/query
//Close the connection

public class MySQLDMLCommands {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		
		//Create a connection
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_tutorial", "root", "password");
	
		//Create a statement/query
		Statement stmt = conn.createStatement();
		// String insert = "INSERT INTO student VALUES (103, 'Martin')";
		// String update = "UPDATE student SET student_name = 'David' WHERE student_id = 103";
		String delete = "DELETE FROM student WHERE student_id = 103";
		
		//Execute a statement/query
		// stmt.execute(insert);
		// stmt.execute(update);
		stmt.execute(delete);
	
		//Close the connection
		conn.close();
		
		System.out.println("Query executed...");	
		
	}

}



// SELECT
// Create a connection
// Create a statement/query
// Execute a statement/query
// Store the results in result set
// Close the connection
