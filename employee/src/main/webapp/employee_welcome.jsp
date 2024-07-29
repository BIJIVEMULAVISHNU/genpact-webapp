<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
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
    <h2>Welcome, ${employeeName}</h2>
    <p>Employee ID: ${empId}</p>
    <p>Manager Name: ${managerName}</p>
    <p>Manager ID: ${managerId}</p>
    <p>Project: ${project}</p>
    
    <a href="change-password.jsp" class="button">Change Password</a>
    <a href="viewTasks.jsp" class="button">View Tasks</a>
    <a href="updateTask.jsp" class="button">Update Task</a>
    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
