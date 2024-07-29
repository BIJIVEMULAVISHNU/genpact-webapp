package manager;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmployeeRegistrationServlet")
public class EmployeeRegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeName = request.getParameter("employeeName");
        String empId = request.getParameter("empId");
        String managerName = request.getParameter("managerName");
        String managerId = request.getParameter("managerId");
        String project = request.getParameter("project");

        // Generate a random password
        String password = generateRandomPassword(10);

        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();

            // Check if managerId exists in the managers table
            String checkManagerSql = "SELECT COUNT(*) FROM managers WHERE managerID = ?";
            stmt = connection.prepareStatement(checkManagerSql);
            stmt.setInt(1, Integer.parseInt(managerId));
            rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                response.sendRedirect("employee_registration_failure.jsp?error=Manager%20ID%20not%20found");
                return;
            }
            rs.close();
            stmt.close();

            // Insert employee data into employees table
            String sql = "INSERT INTO employees (employeeName, empId, password, managerName, managerId, project) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, employeeName);
            stmt.setInt(2, Integer.parseInt(empId));
            stmt.setString(3, password);
            stmt.setString(4, managerName);
            stmt.setInt(5, Integer.parseInt(managerId));
            stmt.setString(6, project);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                request.setAttribute("generatedPassword", password);
                request.getRequestDispatcher("employee_created.jsp").forward(request, response);
            } else {
                response.sendRedirect("LoginFailure.jsp");
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

    private String generateRandomPassword(int length) {
        final String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(characters.length());
            sb.append(characters.charAt(randomIndex));
        }

        return sb.toString();
    }
}
