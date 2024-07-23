<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
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
        .button {
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            display: inline-block;
        }
        .form-container {
            margin-bottom: 20px;
        }
        .form-container input[type="text"] {
            padding: 8px;
            font-size: 16px;
        }
        .form-container button {
            padding: 8px 16px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <h2>Transaction History</h2>

    <%-- Display messages --%>
    <%
        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("message");
        String accountno = request.getParameter("accountno");

        if (errorMessage != null) {
            out.println("<p style='color: red;'>Error: " + errorMessage + "</p>");
        }

        if (successMessage != null) {
            out.println("<p style='color: green;'>Success: " + successMessage + "</p>");
        }
    %>

    <!-- Form for entering account number -->
    <div class="form-container">
        <form action="viewTransactions.jsp" method="get">
            <label for="accountno">Enter Account Number:</label>
            <input type="text" id="accountno" name="accountno" required>
            <button type="submit">Submit</button>
        </form>
    </div>

    <%-- Check if account number is provided --%>
    <%
        if (accountno != null && !accountno.isEmpty()) {
    %>
    
    <table>
        <thead>
            <tr>
                <th>Transaction ID</th>
                <th>Account Number</th>
                <th>Transaction Type</th>
                <th>Amount</th>
                <th>Transaction Date</th>
                <th>Balance</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection to the database
                    String url = "jdbc:mysql://localhost:3306/bankdb";
                    String user = "root";
                    String password = "root";
                    conn = DriverManager.getConnection(url, user, password);

                    // Create SQL query
                    String sql = "SELECT transaction_id, accountno, transaction_type, amount, transaction_date, balance FROM transactions WHERE accountno = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, accountno);
                    rs = pstmt.executeQuery();

                    // Iterate through the result set and display the data
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("transaction_id") + "</td>");
                        out.println("<td>" + rs.getString("accountno") + "</td>");
                        out.println("<td>" + rs.getString("transaction_type") + "</td>");
                        out.println("<td>" + rs.getDouble("amount") + "</td>");
                        out.println("<td>" + rs.getString("transaction_date") + "</td>");
                        out.println("<td>" + rs.getDouble("balance") + "</td>");
                        out.println("</tr>");
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='6'>Error loading database driver: " + e.getMessage() + "</td></tr>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='6'>SQL error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close ResultSet, PreparedStatement, and Connection
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>

    <!-- Download button -->
    <form action="TransactionHistoryServlet" method="get">
        <input type="hidden" name="accountno" value="<%= accountno %>">
        <button type="submit" class="button">Download Transaction History</button>
    </form>
    <% } %>
    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
