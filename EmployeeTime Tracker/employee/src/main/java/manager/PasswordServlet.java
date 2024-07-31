package manager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/PasswordServlet")
public class PasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String managerId = (String) request.getSession().getAttribute("managerId"); // Assuming managerId is stored in session

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // Check current password
            String checkPasswordSql = "SELECT password FROM managers WHERE managerID = ?";
            pstmt = conn.prepareStatement(checkPasswordSql);
            pstmt.setString(1, managerId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (dbPassword.equals(currentPassword)) {
                    // Update password
                    String updatePasswordSql = "UPDATE managers SET password = ? WHERE managerID = ?";
                    pstmt = conn.prepareStatement(updatePasswordSql);
                    pstmt.setString(1, newPassword);
                    pstmt.setString(2, managerId);
                    pstmt.executeUpdate();

                    response.sendRedirect("success.jsp");
                } else {
                    request.setAttribute("errorMessage", "Current password is incorrect.");
                    request.getRequestDispatcher("change-password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "User not found.");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while changing the password.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } finally {
            // Close ResultSet, PreparedStatement, and Connection
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
