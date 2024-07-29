<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .edit-button, .delete-button {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border: none;
            cursor: pointer;
        }
        .delete-button {
            background-color: #f44336;
        }
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
        }
        .button {
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border: none;
            cursor: pointer;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h2>Employee Details</h2>
    
    <%-- Display messages --%>
    <%
        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("message");

        if (errorMessage != null) {
            out.println("<p style='color: red;'>Error: " + errorMessage + "</p>");
        }

        if (successMessage != null) {
            out.println("<p style='color: green;'>Success: " + successMessage + "</p>");
        }
    %>

    <table>
        <thead>
            <tr>
                <th>Employee Name</th>
                <th>Employee ID</th>
                <th>Password</th>
                <th>Manager Name</th>
                <th>Manager ID</th>
                <th>Project</th>
                <th>Edit</th>
                <th>Delete</th>
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
                    String sql = "SELECT employeeName, empId, password, managerName, managerId, project FROM employees";
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display the data
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("employeeName") + "</td>");
                        out.println("<td>" + rs.getInt("empId") + "</td>");
                        out.println("<td>" + rs.getString("password") + "</td>");
                        out.println("<td>" + rs.getString("managerName") + "</td>");
                        out.println("<td>" + rs.getInt("managerId") + "</td>");
                        out.println("<td>" + rs.getString("project") + "</td>");
                        out.println("<td><a href='editEmployee.jsp?empId=" + rs.getInt("empId") + "' class='edit-button'>Edit</a></td>");
                        out.println("<td>");
                        out.println("<form action='DeleteEmployeeServlet' method='POST' style='display:inline;'>");
                        out.println("<input type='hidden' name='empId' value='" + rs.getInt("empId") + "'>");
                        out.println("<button type='submit' class='delete-button'>Delete</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='8'>Error loading database driver: " + e.getMessage() + "</td></tr>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='8'>SQL error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close ResultSet, Statement, and Connection
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>
    <div class="button-container">
        <a href="loginsuccess.jsp" class="button">Back to Manager Dashboard</a>
        <a href="employeeTasksDetails.jsp" class="button">Employee Tasks Details</a>
    </div>
</body>
</html>
