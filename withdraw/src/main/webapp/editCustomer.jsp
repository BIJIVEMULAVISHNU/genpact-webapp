<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer Details</title>
    <style>
        /* Add your CSS styling here */
        .form-container {
            width: 50%;
            margin: auto;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="email"], input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button.cancel {
            background-color: #f44336;
        }
    </style>
</head>
<body>
    <h2>Edit Customer Details</h2>
    
    <%
        String accountno = request.getParameter("accountno");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        if (accountno != null) {
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your database URL
                String user = "root"; // Update with your database username
                String password = "root"; // Update with your database password
                conn = DriverManager.getConnection(url, user, password);

                // Create SQL statement
                String sql = "SELECT * FROM accounts WHERE accountno = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, accountno);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String fullname = rs.getString("fullname");
                    String address = rs.getString("address");
                    String phonenumber = rs.getString("phonenumber");
                    String accounttype = rs.getString("accounttype");
                    String dateofbirth = rs.getString("dateofbirth");
                    String idproof = rs.getString("idproof");
                    String emailid = rs.getString("emailid");
    %>
    <div class="form-container">
        <form action="UpdateCustomerServlet" method="POST">
            <input type="hidden" name="accountno" value="<%= accountno %>">
            
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" value="<%= fullname %>" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= address %>" required>

            <label for="phonenumber">Phone Number:</label>
            <input type="text" id="phonenumber" name="phonenumber" value="<%= phonenumber %>" required>

            <label for="accounttype">Account Type:</label>
            <input type="text" id="accounttype" name="accounttype" value="<%= accounttype %>" required>

            <label for="dateofbirth">Date of Birth:</label>
            <input type="date" id="dateofbirth" name="dateofbirth" value="<%= dateofbirth %>" required>

            <label for="idproof">ID Proof:</label>
            <input type="text" id="idproof" name="idproof" value="<%= idproof %>" required>

            <label for="emailid">Email ID:</label>
            <input type="email" id="emailid" name="emailid" value="<%= emailid %>" required>

            <button type="submit">Update</button>
            <a href="customerDetails.jsp" class="button cancel">Cancel</a>
        </form>
    </div>
    <%
                } else {
                    out.println("<p>No customer found with account number: " + accountno + "</p>");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<p>Error loading database driver: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>SQL error: " + e.getMessage() + "</p>");
            } finally {
                // Close ResultSet, PreparedStatement, and Connection
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        } else {
            out.println("<p>Account number is missing.</p>");
        }
    %>
</body>
</html>
