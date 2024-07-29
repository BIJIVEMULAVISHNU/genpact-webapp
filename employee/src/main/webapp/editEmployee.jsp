<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>
    <style>
        form {
            width: 400px;
            margin: 0 auto;
        }
        div {
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Edit Employee</h2>

    <%
        String empId = request.getParameter("empId");
        if (empId == null || empId.isEmpty()) {
            out.println("<p style='color: red;'>Employee ID is missing!</p>");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // Create SQL statement
            String sql = "SELECT employeeName, empId, password, managerName, managerId, project FROM employees WHERE empId = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(empId));
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
    <form action="UpdateEmployeeServlet" method="POST">
        <div>
            <label for="employeeName">Employee Name:</label>
            <input type="text" id="employeeName" name="employeeName" value="<%= rs.getString("employeeName") %>" required>
        </div>
        <div>
            <label for="empId">Employee ID:</label>
            <input type="text" id="empId" name="empId" value="<%= rs.getInt("empId") %>" readonly>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="<%= rs.getString("password") %>" required>
        </div>
        <div>
            <label for="managerName">Manager Name:</label>
            <input type="text" id="managerName" name="managerName" value="<%= rs.getString("managerName") %>" required>
        </div>
        <div>
            <label for="managerId">Manager ID:</label>
            <input type="number" id="managerId" name="managerId" value="<%= rs.getInt("managerId") %>" required>
        </div>
        <div>
            <label for="project">Project:</label>
            <input type="text" id="project" name="project" value="<%= rs.getString("project") %>" required>
        </div>
        <div>
            <input type="submit" value="Update Employee">
        </div>
    </form>
    <%
            } else {
                out.println("<p style='color: red;'>Employee not found!</p>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p style='color: red;'>Error loading database driver: " + e.getMessage() + "</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p style='color: red;'>SQL error: " + e.getMessage() + "</p>");
        } finally {
            // Close ResultSet, Statement, and Connection
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
