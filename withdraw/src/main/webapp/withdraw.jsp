<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Operations</title>
</head>
<body>
    <h2>Bank Operations</h2>
    <form action="withdrawServlet" method="post">
        Enter account number: <input type="text" name="accNo"><br><br>
        Enter amount: <input type="text" name="amount"><br><br>
        <input type="radio" name="action" value="withdraw" checked> Withdraw<br>
        <input type="radio" name="action" value="deposit"> Deposit<br><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
