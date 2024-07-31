package manager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import employee.Task;
@WebServlet("/ViewTaskServlet")
public class ViewTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empid"); // Ensure this matches the form field name

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Task> tasks = new ArrayList<>();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // Query to get tasks for the employee
            String sql = "SELECT * FROM employee_tasks WHERE empid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, empId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("taskid"));
                task.setEmployeeName(rs.getString("employeename"));
                task.setEmpId(rs.getString("empid"));
                task.setRole(rs.getString("role"));
                task.setProject(rs.getString("project"));
                task.setManagerId(rs.getString("managerid"));
                task.setManagerName(rs.getString("managername"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTime("start_time"));
                task.setEndTime(rs.getTime("end_time"));
                task.setTaskCategory(rs.getString("taskcategory"));
                task.setDescription(rs.getString("description"));
                tasks.add(task);
            }

            request.setAttribute("tasks", tasks);
            request.getRequestDispatcher("viewTasks.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving tasks.");
            request.getRequestDispatcher("viewTasks.jsp").forward(request, response);
        } finally {
            // Close ResultSet, PreparedStatement, and Connection
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
