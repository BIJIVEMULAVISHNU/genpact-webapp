<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
    <style>
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 15px;
            box-shadow: 0 9px #999;
        }

        .button:hover {background-color: #3e8e41}

        .button:active {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
    </style>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <h2>Customer Details</h2>
    <p>Full Name: <%= request.getAttribute("fullName") %></p>
    <p>Address: <%= request.getAttribute("address") %></p>
    <p>Phone Number: <%= request.getAttribute("phoneNumber") %></p>
    <p>Account Type: <%= request.getAttribute("accountType") %></p>
    <p>Date of Birth: <%= request.getAttribute("dateOfBirth") %></p>
    <p>ID Proof: <%= request.getAttribute("idProof") %></p>
    <p>Email ID: <%= request.getAttribute("emailId") %></p>
    
    <a href="change-password.jsp" class="button">Change Password</a>
    <a href="viewTransactions.jsp" class="button">Transaction History</a>
    <a href="withdraw.jsp" class="button">Withdraw</a>
    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
