package employee;

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

@WebServlet("/EmployeeLoginServlet")
public class EmployeeLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");
        String password = request.getParameter("password");

        if (empId == null || password == null) {
            response.sendRedirect("LoginFailure1.jsp");
            return;
        }

        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            String sql = "SELECT * FROM employees WHERE empId = ? AND password = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(empId));
            stmt.setString(2, password);

            rs = stmt.executeQuery();

            if (rs.next()) {
                String employeeName = rs.getString("employeeName");
                String managerName = rs.getString("managerName");
                String project = rs.getString("project");

                HttpSession session = request.getSession();
                session.setAttribute("employeeName", employeeName);
                session.setAttribute("empId", empId);
                session.setAttribute("managerName", managerName);
                session.setAttribute("project", project);

                request.getRequestDispatcher("employee_welcome.jsp").forward(request, response);
            } else {
                response.sendRedirect("LoginFailure.jsp");
            }

        } catch (SQLException e) {
            throw new ServletException("Error communicating with database", e);
        } finally {
            try {
                if (rs != null) rs.close();
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
