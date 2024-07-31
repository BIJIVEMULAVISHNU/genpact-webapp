<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
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
</head>
<body>
    <h2>Edit Task</h2>
    <form action="UpdateEmployeeTaskServlet" method="post">
        <input type="hidden" name="taskid" value="<%= request.getAttribute("taskid") %>">
        Employee Name: <input type="text" name="employeename" value="<%= request.getAttribute("employeename") %>" required><br>
        Employee ID: <input type="text" name="empid" value="<%= request.getAttribute("empid") %>" required><br>
        Role: <input type="text" name="role" value="<%= request.getAttribute("role") %>" required><br>
        Project: <input type="text" name="project" value="<%= request.getAttribute("project") %>" required><br>
        Manager ID: <input type="text" name="managerid" value="<%= request.getAttribute("managerid") %>" required><br>
        Manager Name: <input type="text" name="managername" value="<%= request.getAttribute("managername") %>" required><br>
        Date: <input type="date" name="date" value="<%= request.getAttribute("date") %>" required><br>
        Start Time: <input type="time" name="start_time" value="<%= request.getAttribute("start_time") %>" required><br>
        End Time: <input type="time" name="end_time" value="<%= request.getAttribute("end_time") %>" required><br>
        Task Category: <input type="text" name="taskcategory" value="<%= request.getAttribute("taskcategory") %>" required><br>
        Description: <textarea name="description" rows="4" cols="50" required><%= request.getAttribute("description") %></textarea><br>
        <input type="submit" value="Update Task">
    </form>
    <a href="employee-task-details.jsp?taskid=<%= request.getAttribute("taskid") %>" class="button">Back to Task Details</a>
</body>
</html>
