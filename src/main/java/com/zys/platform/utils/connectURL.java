package com.zys.platform.utils;

import java.sql.*;

public class connectURL {

	public static void main(String[] args) {

		// Create a variable for the connection string.
		String connectionUrl = "jdbc:sqlserver://192.168.200.128\\sql2008:1433;"
				+ "databaseName=PlatformAcctDb;user=sa;password=FSmElsXuj3ls8Fq";
		// connectionUrl中的sql2008是我服务器上的sql2008别名
		// Declare the JDBC objects.
		String url = "jdbc:sqlserver://192.168.200.128:1433;databaseName=PlatformAcctDb";
		String usrname = "sa";
		String passWord = "FSmElsXuj3ls8Fq";
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			System.out.println("Print the record.");
			// Establish the connection.
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//			con = DriverManager.getConnection(connectionUrl);
			con = DriverManager.getConnection(url,usrname,passWord);

			// Create and execute an SQL statement that returns some data.
			String SQL = "SELECT TOP 20 * FROM PlatformAcctDb.dbo.Users";
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);

			// Iterate through the data in the result set and display it.
			while (rs.next()) {
				System.out.println(rs.getString(4) + " " + rs.getString(6));
			}
		}

		// Handle any errors that may have occurred.
		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (Exception e) {
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
				}
		}
	}
}
