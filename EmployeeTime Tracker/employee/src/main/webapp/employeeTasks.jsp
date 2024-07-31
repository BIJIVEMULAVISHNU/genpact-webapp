<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Tasks Details</title>
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
    </style>
</head>
<body>
    <h2>Employee Tasks Details</h2>

    <table>
        <thead>
            <tr>
                <th>Task ID</th>
                <th>Employee Name</th>
                <th>Employee ID</th>
                <th>Role</th>
                <th>Project</th>
                <th>Manager ID</th>
                <th>Manager Name</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Task Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String empId = (String) session.getAttribute("empid"); // Retrieve empID from session

                if (empId != null) {
                    try {
                        // Load MySQL JDBC Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection to the database
                        String url = "jdbc:mysql://localhost:3306/bankdb";
                        String user = "root";
                        String password = "root";
                        conn = DriverManager.getConnection(url, user, password);

                        // Create SQL statement with parameter for employee ID
                        String sql = "SELECT * FROM employee_tasks WHERE empid = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, empId);
                        rs = pstmt.executeQuery();

                        // Iterate through the result set and display the data
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("taskid") + "</td>");
                            out.println("<td>" + rs.getString("employeename") + "</td>");
                            out.println("<td>" + rs.getString("empid") + "</td>");
                            out.println("<td>" + rs.getString("role") + "</td>");
                            out.println("<td>" + rs.getString("project") + "</td>");
                            out.println("<td>" + rs.getString("managerid") + "</td>");
                            out.println("<td>" + rs.getString("managername") + "</td>");
                            out.println("<td>" + rs.getDate("date") + "</td>");
                            out.println("<td>" + rs.getTime("start_time") + "</td>");
                            out.println("<td>" + rs.getTime("end_time") + "</td>");
                            out.println("<td>" + rs.getString("taskcategory") + "</td>");
                            out.println("<td>" + rs.getString("description") + "</td>");
                            out.println("<td>");
                            out.println("<a href='editTask.jsp?taskid=" + rs.getInt("taskid") + "'>Edit</a> | ");
                            out.println("<a href='deleteTaskServlet?taskid=" + rs.getInt("taskid") + "'>Delete</a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='13'>Error loading database driver: " + e.getMessage() + "</td></tr>");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='13'>SQL error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        // Close ResultSet, PreparedStatement, and Connection
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                } else {
                    out.println("<tr><td colspan='13'>No employee ID found in session.</td></tr>");
                }
            %>
        </tbody>
    </table>
</body>
</html>
