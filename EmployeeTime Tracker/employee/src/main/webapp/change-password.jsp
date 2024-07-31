<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin: 10px 0 5px;
            color: #333;
        }
        input[type="password"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
            font-size: 16px;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
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
            border-radius: 5px;
            box-shadow: 0 4px #999;
            margin-top: 10px;
        }
        .button:hover {
            background-color: #3e8e41;
        }
        .button:active {
            background-color: #3e8e41;
            box-shadow: 0 2px #666;
            transform: translateY(2px);
        }
        .back-button {
            background-color: #f44336;
        }
        .back-button:hover {
            background-color: #e53935;
        }
    </style>
    <script>
        function validateForm() {
            var currentPassword = document.forms["changePasswordForm"]["currentPassword"].value;
            var newPassword = document.forms["changePasswordForm"]["newPassword"].value;
            var confirmPassword = document.forms["changePasswordForm"]["confirmPassword"].value;

            var errors = false;

            // Current Password validation
            if (currentPassword === "") {
                document.getElementById("currentPasswordError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("currentPasswordError").style.display = "none";
            }

            // New Password validation
            if (newPassword === "" || newPassword.length < 8) {
                document.getElementById("newPasswordError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("newPasswordError").style.display = "none";
            }

            // Confirm Password validation
            if (confirmPassword !== newPassword) {
                document.getElementById("confirmPasswordError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("confirmPasswordError").style.display = "none";
            }

            return !errors;
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        <form name="changePasswordForm" action="ChangePasswordServlet" method="post" onsubmit="return validateForm()">
            <label for="currentPassword">Current Password:</label>
            <input type="password" name="currentPassword" id="currentPassword" required>
            <span id="currentPasswordError" class="error">Current password is required.</span>

            <label for="newPassword">New Password:</label>
            <input type="password" name="newPassword" id="newPassword" required>
            <span id="newPasswordError" class="error">New password must be at least 8 characters long.</span>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" name="confirmPassword" id="confirmPassword" required>
            <span id="confirmPasswordError" class="error">Passwords do not match.</span>

            <input type="submit" value="Change Password" class="button">
        </form>

        <button class="button back-button" onclick="goBack()">Back</button>
    </div>
</body>
</html>
