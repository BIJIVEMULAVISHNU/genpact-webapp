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

@WebServlet("/managerServlet")
public class managerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String managerName = request.getParameter("managerName");
        String password = request.getParameter("password");

        if (managerName == null || password == null) {
            response.sendRedirect("LoginFailure.jsp");
            return;
        }

        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            String sql = "SELECT * FROM managers WHERE managerName = ? AND password = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, managerName);
            stmt.setString(2, password);

            rs = stmt.executeQuery();

            if (rs.next()) {
                String project = rs.getString("project");  // Change to project column

                request.setAttribute("username", managerName);
                request.setAttribute("project", project);

                request.getRequestDispatcher("loginsuccess.jsp").forward(request, response);
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
