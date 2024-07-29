<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
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
    <h2>Change Password</h2>
    <form name="changePasswordForm" action="ChangePasswordServlet" method="post" onsubmit="return validateForm()">
        Current Password: <input type="password" name="currentPassword" required><br>
        <span id="currentPasswordError" class="error">Current password is required.</span><br>
        New Password: <input type="password" name="newPassword" required><br>
        <span id="newPasswordError" class="error">New password must be at least 8 characters long.</span><br>
        Confirm Password: <input type="password" name="confirmPassword" required><br>
        <span id="confirmPasswordError" class="error">Passwords do not match.</span><br>
        <input type="submit" value="Change Password" class="button">
    </form>

    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
