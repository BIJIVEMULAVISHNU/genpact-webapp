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

@WebServlet("/deleteTaskServlet")
public class deleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskid = Integer.parseInt(request.getParameter("taskid"));
        
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

            // Create SQL delete statement
            String sql = "DELETE FROM employee_tasks WHERE taskid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskid);
            stmt.executeUpdate();

            response.sendRedirect("viewEmployeeTasks.jsp"); // Redirect to the tasks details page
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
