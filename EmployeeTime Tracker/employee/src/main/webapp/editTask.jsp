<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int taskid = Integer.parseInt(request.getParameter("taskid"));
    String employeename = "";
    String empid = "";
    String role = "";
    String project = "";
    String managerid = "";
    String managername = "";
    Date date = null;
    Time start_time = null;
    Time end_time = null;
    String taskcategory = "";
    String description = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your database URL
        String user = "root"; // Update with your database username
        String password = "root"; // Update with your database password
        conn = DriverManager.getConnection(url, user, password);

        // Create SQL select statement
        String sql = "SELECT * FROM employee_tasks WHERE taskid = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, taskid);
        rs = stmt.executeQuery();

        if (rs.next()) {
            employeename = rs.getString("employeename");
            empid = rs.getString("empid");
            role = rs.getString("role");
            project = rs.getString("project");
            managerid = rs.getString("managerid");
            managername = rs.getString("managername");
            date = rs.getDate("date");
            start_time = rs.getTime("start_time");
            end_time = rs.getTime("end_time");
            taskcategory = rs.getString("taskcategory");
            description = rs.getString("description");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close ResultSet, Statement, and Connection
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
</head>
<body>
    <h2>Edit Task</h2>
    <form action="updateTaskServlet" method="post">
        <input type="hidden" name="taskid" value="<%= taskid %>">
        <label for="employeename">Employee Name:</label>
        <input type="text" id="employeename" name="employeename" value="<%= employeename %>"><br>

        <label for="empid">Employee ID:</label>
        <input type="text" id="empid" name="empid" value="<%= empid %>"><br>

        <label for="role">Role:</label>
        <input type="text" id="role" name="role" value="<%= role %>"><br>

        <label for="project">Project:</label>
        <input type="text" id="project" name="project" value="<%= project %>"><br>

        <label for="managerid">Manager ID:</label>
        <input type="text" id="managerid" name="managerid" value="<%= managerid %>"><br>

        <label for="managername">Manager Name:</label>
        <input type="text" id="managername" name="managername" value="<%= managername %>"><br>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="<%= date %>"><br>

        <label for="start_time">Start Time:</label>
        <input type="time" id="start_time" name="start_time" value="<%= start_time %>"><br>

        <label for="end_time">End Time:</label>
        <input type="time" id="end_time" name="end_time" value="<%= end_time %>"><br>

        <label for="taskcategory">Task Category:</label>
        <input type="text" id="taskcategory" name="taskcategory" value="<%= taskcategory %>"><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description"><%= description %></textarea><br>

        <input type="submit" value="Update Task">
    </form>
</body>
</html>
