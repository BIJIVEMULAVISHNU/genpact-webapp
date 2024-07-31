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

@WebServlet("/UpdateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeName = request.getParameter("employeeName");
        String empId = request.getParameter("empId");
        String password = request.getParameter("password");
        String managerName = request.getParameter("managerName");
        String managerId = request.getParameter("managerId");
        String project = request.getParameter("project");

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            String sql = "UPDATE employees SET employeeName = ?, password = ?, managerName = ?, managerId = ?, project = ? WHERE empId = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, employeeName);
            stmt.setString(2, password);
            stmt.setString(3, managerName);
            stmt.setInt(4, Integer.parseInt(managerId));
            stmt.setString(5, project);
            stmt.setInt(6, Integer.parseInt(empId));

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("employeeDetails.jsp?message=Employee updated successfully");
            } else {
                response.sendRedirect("editEmployee.jsp?empId=" + empId + "&error=Failed to update employee");
            }
        } catch (SQLException e) {
            throw new ServletException("Error communicating with database", e);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private Connection getConnection() throws SQLException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/bankdb?useSSL=false&allowPublicKeyRetrieval=true";
        String jdbcUser = "root";
        String jdbcPassword = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
}
