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

@WebServlet("/ViewEmployeeTaskServlet")
public class ViewEmployeeTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
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
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb"; // Update with your DB name
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // Create SQL statement to insert task details
            String sql = "INSERT INTO employee_tasks (employeename, empid, role, project, managerid, managername, date, start_time, end_time, taskcategory, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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

            // Execute the insertion
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("success.jsp"); // Redirect to a success page
            } else {
                response.sendRedirect("error.jsp?error=Failed to add task");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=Database error: " + e.getMessage());
        } finally {
            // Close PreparedStatement and Connection
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}