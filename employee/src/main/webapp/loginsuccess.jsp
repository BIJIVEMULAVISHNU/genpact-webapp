<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script>
        function showSuccessMessage() {
            var successMessage = document.getElementById('success-message');
            successMessage.style.display = 'block';
            document.body.style.animation = 'blink 1s';
            setTimeout(function() {
                document.body.style.animation = '';
            }, 500);
        }
        window.onload = showSuccessMessage;
    </script>
</head>
<body>
    <div class="container">
        <h1>Welcome Admin</h1>
        <div id="success-message" class="success-message">Login Successfully</div>
        <button class="button" onclick="location.href='employee_registration_form.jsp'">Create Employee</button>
        <button class="button" onclick="location.href='employee_login_form.jsp'">Employee Login</button>
        <button class="button" onclick="location.href='employeeDetails.jsp'">Employee Details</button>
        <button class="button" onclick="location.href='manager.jsp'">Back to Manager Login</button>
    </div>
</body>
</html>
