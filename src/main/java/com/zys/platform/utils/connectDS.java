package com.zys.platform.utils;

import java.sql.*;
import com.microsoft.sqlserver.jdbc.*;

public class connectDS {

	public static void main(String[] args) {

		// Declare the JDBC objects.
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			// Establish the connection.
			SQLServerDataSource ds = new SQLServerDataSource();
			ds.setUser("sa");// 数据库用户名
			ds.setPassword("sa");// 数据库密码
			ds.setServerName("HIOF-SHUAIT");// 服务器名
			ds.setPortNumber(1433); // 端口号
			ds.setDatabaseName("AdventureWorks");// 访问的数据库
			con = ds.getConnection();

			// Execute a stored procedure that returns some data.
			cstmt = con.prepareCall("{call dbo.uspGetEmployeeManagers(?)}");
			cstmt.setInt(1, 50);
			rs = cstmt.executeQuery();

			// Iterate through the data in the result set and display it.
			while (rs.next()) {
				System.out.println("EMPLOYEE: " + rs.getString("LastName") + ", " + rs.getString("FirstName"));
				System.out.println(
						"MANAGER: " + rs.getString("ManagerLastName") + ", " + rs.getString("ManagerFirstName"));
				System.out.println();
			}
		}

		// Handle any errors that may have occurred.
		catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			if (cstmt != null)
				try {
					cstmt.close();
				} catch (Exception e) {
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
				}
			System.exit(1);
		}
	}
}