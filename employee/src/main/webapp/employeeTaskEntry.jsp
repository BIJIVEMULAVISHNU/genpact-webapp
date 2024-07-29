<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Task Entry</title>
   
</head>
<body>
    <h2>Employee Task Entry Form</h2>

    <h3>Current Managers</h3>
    <table>
        <thead>
            <tr>
                <th>Manager ID</th>
                <th>Manager Name</th>
                <th>Project</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection to the database
                    String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your database URL
                    String user = "root"; // Update with your database username
                    String password = "root"; // Update with your database password
                    conn = DriverManager.getConnection(url, user, password);

                    // Create SQL statement
                    stmt = conn.createStatement();
                    String sql = "SELECT managerId, managerName, project FROM managers"; // Use the correct table name
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display the data
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("managerId") + "</td>");
                        out.println("<td>" + rs.getString("managerName") + "</td>");
                        out.println("<td>" + rs.getString("project") + "</td>");
                        out.println("</tr>");
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='3'>Error loading database driver: " + e.getMessage() + "</td></tr>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='3'>SQL error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close ResultSet, Statement, and Connection
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>

    <form action="ViewEmployeeTaskServlet" method="post">
        Employee Name: <input type="text" name="employeename" required><br>
        Employee ID: <input type="text" name="empid" required><br>
        Role: <input type="text" name="role" required><br>
        Project: <input type="text" name="project" required><br>
        Manager ID: <input type="text" name="managerid" required><br>
        Manager Name: <input type="text" name="managername" required><br>
        Date: <input type="date" name="date" required><br>
        Start Time: <input type="time" name="start_time" required><br>
        End Time: <input type="time" name="end_time" required><br>
        Task Category: <input type="text" name="taskcategory" required><br>
        Description: <textarea name="description" required></textarea><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
