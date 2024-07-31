<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Registration</title>
    
    <script>
        function validateForm() {
            var employeeName = document.forms["registrationForm"]["employeeName"].value;
            var empId = document.forms["registrationForm"]["empId"].value;
            var managerName = document.forms["registrationForm"]["managerName"].value;
            var managerId = document.forms["registrationForm"]["managerId"].value;
            var project = document.forms["registrationForm"]["project"].value;

            var errors = false;

            // Employee Name validation
            if (!/^[a-zA-Z\s]+$/.test(employeeName)) {
                document.getElementById("employeeNameError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("employeeNameError").style.display = "none";
            }

            // Employee ID validation
            if (!/^\d+$/.test(empId)) {
                document.getElementById("empIdError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("empIdError").style.display = "none";
            }

            // Manager Name validation
            if (!/^[a-zA-Z\s]+$/.test(managerName)) {
                document.getElementById("managerNameError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("managerNameError").style.display = "none";
            }

            // Manager ID validation
            if (!/^\d+$/.test(managerId)) {
                document.getElementById("managerIdError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("managerIdError").style.display = "none";
            }

            // Project validation
            if (!/^[a-zA-Z\s]+$/.test(project)) {
                document.getElementById("projectError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("projectError").style.display = "none";
            }

            return !errors;
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <h2>Employee Registration Form</h2>

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

    <form name="registrationForm" action="EmployeeRegistrationServlet" method="Post" onsubmit="return validateForm()">
        Employee Name: <input type="text" name="employeeName" required><br>
        <span id="employeeNameError" class="error"></span><br>
        Employee ID: <input type="text" name="empId" required><br>
        <span id="empIdError" class="error"></span><br>
        Manager Name: <input type="text" name="managerName" required><br>
        <span id="managerNameError" class="error"></span><br>
        Manager ID: <input type="text" name="managerId" required><br>
        <span id="managerIdError" class="error"></span><br>
        Project: <input type="text" name="project" required><br>
        <span id="projectError" class="error"></span><br>

        <input type="submit" value="Register">
    </form>

    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
