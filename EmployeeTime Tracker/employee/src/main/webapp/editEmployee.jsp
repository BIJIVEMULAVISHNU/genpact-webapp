<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            text-align: left;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            width: 100%;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"], input[type="password"], input[type="number"] {
            width: calc(100% - 16px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Employee</h2>

        <%
            String empId = request.getParameter("empId");
            if (empId == null || empId.isEmpty()) {
                out.println("<p class='error'>Employee ID is missing!</p>");
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
                    out.println("<p class='error'>Employee not found!</p>");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<p class='error'>Error loading database driver: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p class='error'>SQL error: " + e.getMessage() + "</p>");
            } finally {
                // Close ResultSet, Statement, and Connection
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>
</body>
</html>
