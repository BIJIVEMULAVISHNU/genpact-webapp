package employee;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEmployeeTaskServlet")
public class UpdateEmployeeTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskid = request.getParameter("taskid");
        String employeename = request.getParameter("employeename");
        String empid = request.getParameter("empid");
        String role = request.getParameter("role");
        String project = request.getParameter("project");
        String managerid = request.getParameter("managerid");
        String managername = request.getParameter("managername");
        String date = request.getParameter("date");
        String start_time = request.getParameter("start_time");
        String end_time = request.getParameter("end_time");
        String taskcategory = request.getParameter("taskcategory");
        String description = request.getParameter("description");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your DB name
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            String sql = "UPDATE employee_tasks SET employeename=?, empid=?, role=?, project=?, managerid=?, managername=?, date=?, start_time=?, end_time=?, taskcategory=?, description=? WHERE taskid=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, employeename);
            pstmt.setString(2, empid);
            pstmt.setString(3, role);
            pstmt.setString(4, project);
            pstmt.setString(5, managerid);
            pstmt.setString(6, managername);
            pstmt.setString(7, date);
            pstmt.setString(8, start_time);
            pstmt.setString(9, end_time);
            pstmt.setString(10, taskcategory);
            pstmt.setString(11, description);
            pstmt.setString(12, taskid);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("employee-task-details.jsp?taskid=" + taskid + "&message=Task updated successfully");
            } else {
                response.sendRedirect("employee-task-details.jsp?taskid=" + taskid + "&error=Failed to update task");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("employee-task-details.jsp?taskid=" + taskid + "&error=Error loading database driver: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("employee-task-details.jsp?taskid=" + taskid + "&error=SQL error: " + e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
