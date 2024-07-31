package employee;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateTaskServlet")
public class updateTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskid = Integer.parseInt(request.getParameter("taskid"));
        String employeename = request.getParameter("employeename");
        String empid = request.getParameter("empid");
        String role = request.getParameter("role");
        String project = request.getParameter("project");
        String managerid = request.getParameter("managerid");
        String managername = request.getParameter("managername");
        Date date = Date.valueOf(request.getParameter("date"));
        Time start_time = Time.valueOf(request.getParameter("start_time"));
        Time end_time = Time.valueOf(request.getParameter("end_time"));
        String taskcategory = request.getParameter("taskcategory");
        String description = request.getParameter("description");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your database URL
            String user = "root"; // Update with your database username
            String password = "root"; // Update with your database password
            conn = DriverManager.getConnection(url, user, password);

            // Create SQL update statement
            String sql = "UPDATE employee_tasks SET employeename = ?, empid = ?, role = ?, project = ?, managerid = ?, managername = ?, date = ?, start_time = ?, end_time = ?, taskcategory = ?, description = ? WHERE taskid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, employeename);
            stmt.setString(2, empid);
            stmt.setString(3, role);
            stmt.setString(4, project);
            stmt.setString(5, managerid);
            stmt.setString(6, managername);
            stmt.setDate(7, date);
            stmt.setTime(8, start_time);
            stmt.setTime(9, end_time);
            stmt.setString(10, taskcategory);
            stmt.setString(11, description);
            stmt.setInt(12, taskid);
            stmt.executeUpdate();

            // Redirect to the tasks details page
            response.sendRedirect("viewEmployeeTasks.jsp");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close Statement and Connection
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
