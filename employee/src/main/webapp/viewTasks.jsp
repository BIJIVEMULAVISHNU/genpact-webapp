<%@ page import="java.util.List" %>
<%@ page import="employee.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Tasks</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Employee Tasks</h2>
    <table>
        <thead>
            <tr>
                <th>Task ID</th>
                <th>Employee Name</th>
                <th>Employee ID</th>
                <th>Role</th>
                <th>Project</th>
                <th>Manager ID</th>
                <th>Manager Name</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Task Category</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                if (tasks != null && !tasks.isEmpty()) {
                    for (Task task : tasks) {
            %>
            <tr>
                <td><%= task.getTaskId() %></td>
                <td><%= task.getEmployeeName() %></td>
                <td><%= task.getEmpId() %></td>
                <td><%= task.getRole() %></td>
                <td><%= task.getProject() %></td>
                <td><%= task.getManagerId() %></td>
                <td><%= task.getManagerName() %></td>
                <td><%= task.getDate() %></td>
                <td><%= task.getStartTime() %></td>
                <td><%= task.getEndTime() %></td>
                <td><%= task.getTaskCategory() %></td>
                <td><%= task.getDescription() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="12">No tasks found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
