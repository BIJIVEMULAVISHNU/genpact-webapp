package customer.loginServlet;

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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection conn;

    public void init() throws ServletException {
        // Initialize database connection
        String dbURL = "jdbc:mysql://localhost:3306/bankdb";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        if (validateAndUpdatePassword(accountNo, currentPassword, newPassword)) {
            response.sendRedirect("password-change-success.jsp");
        } else {
            response.sendRedirect("password-change-failure.jsp");
        }
    }

    private boolean validateAndUpdatePassword(String accountNo, String currentPassword, String newPassword) {
        PreparedStatement stmt = null;
        boolean passwordUpdated = false;

        try {
            // Check current password
            String query = "SELECT password FROM accounts WHERE accountno = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, accountNo);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (storedPassword.equals(currentPassword)) {
                    // Update password
                    String updateQuery = "UPDATE accounts SET password = ? WHERE accountno = ?";
                    stmt = conn.prepareStatement(updateQuery);
                    stmt.setString(1, newPassword);
                    stmt.setString(2, accountNo);

                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        passwordUpdated = true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close statement and result set
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return passwordUpdated;
    }

    public void destroy() {
        // Close database connection
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
