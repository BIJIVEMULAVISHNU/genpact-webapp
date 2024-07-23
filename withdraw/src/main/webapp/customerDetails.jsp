<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
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
    <h2>Customer Details</h2>
    
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
                <th>Account Number</th>
                <th>Full Name</th>
                <th>Address</th>
                <th>Phone Number</th>
                <th>Account Type</th>
                <th>Date of Birth</th>
                <th>ID Proof</th>
                <th>Email ID</th>
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
                    String sql = "SELECT accountno, fullname, address, phonenumber, accounttype, dateofbirth, idproof, emailid FROM accounts";
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display the data
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("accountno") + "</td>");
                        out.println("<td>" + rs.getString("fullname") + "</td>");
                        out.println("<td>" + rs.getString("address") + "</td>");
                        out.println("<td>" + rs.getString("phonenumber") + "</td>");
                        out.println("<td>" + rs.getString("accounttype") + "</td>");
                        out.println("<td>" + rs.getString("dateofbirth") + "</td>");
                        out.println("<td>" + rs.getString("idproof") + "</td>");
                        out.println("<td>" + rs.getString("emailid") + "</td>");
                        out.println("<td><a href='editCustomer.jsp?accountno=" + rs.getString("accountno") + "' class='edit-button'>Edit</a></td>");
                        out.println("<td>");
                        out.println("<form action='DeleteCustomerServlet' method='POST' style='display:inline;'>");
                        out.println("<input type='hidden' name='accountno' value='" + rs.getString("accountno") + "'>");
                        out.println("<button type='submit' class='delete-button'>Delete</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='10'>Error loading database driver: " + e.getMessage() + "</td></tr>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='10'>SQL error: " + e.getMessage() + "</td></tr>");
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
        <a href="loginsuccess.html" class="button">Back to Admin Dashboard</a>
        <a href="viewTransactions.jsp" class="button">Transaction History</a>
        </div>
</body>
</html>
