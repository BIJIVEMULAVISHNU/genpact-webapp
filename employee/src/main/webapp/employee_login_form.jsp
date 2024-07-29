<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Login</title>
    <style>
        .error {
            color: red;
            display: none;
        }
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
        function validateForm() {
            var empId = document.forms["loginForm"]["empId"].value;
            var password = document.forms["loginForm"]["password"].value;

            var errors = false;

            // Employee ID validation
            if (!/^\d+$/.test(empId)) {
                document.getElementById("empIdError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("empIdError").style.display = "none";
            }

            // Password validation
            if (password.length === 0) {
                document.getElementById("passwordError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("passwordError").style.display = "none";
            }

            return !errors;
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <h2>Employee Login Form</h2>
    <form name="loginForm" action="EmployeeLoginServlet" method="Post" onsubmit="return validateForm()">
        Employee ID: <input type="text" name="empId" required><br>
        <span id="empIdError" class="error">Employee ID should contain only numbers.</span><br>
        Password: <input type="password" name="password" required><br>
        <span id="passwordError" class="error">Password cannot be empty.</span><br>

        <input type="submit" value="Login">
    </form>

    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
