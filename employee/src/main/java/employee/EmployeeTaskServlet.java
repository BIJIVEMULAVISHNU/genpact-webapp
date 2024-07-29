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

@WebServlet("/EmployeeTaskServlet")
public class EmployeeTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeename = request.getParameter("employeename");
        int empid = Integer.parseInt(request.getParameter("empid"));
        String role = request.getParameter("role");
        String project = request.getParameter("project");
        int managerid = Integer.parseInt(request.getParameter("managerid"));
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "root");
            String sql = "INSERT INTO employee_tasks (employeename, empid, role, project, managerid, managername, date, start_time, end_time, taskcategory, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, employeename);
            pstmt.setInt(2, empid);
            pstmt.setString(3, role);
            pstmt.setString(4, project);
            pstmt.setInt(5, managerid);
            pstmt.setString(6, managername);
            pstmt.setString(7, date);
            pstmt.setString(8, start_time);
            pstmt.setString(9, end_time);
            pstmt.setString(10, taskcategory);
            pstmt.setString(11, description);
            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("employee-task-details.jsp");
    }
}
