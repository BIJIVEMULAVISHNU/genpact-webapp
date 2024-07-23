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

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountno");
        String password = request.getParameter("password");

        try {
            Connection connection = getConnection();
            String sql = "SELECT * FROM accounts WHERE accountno = ? AND password = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, accountNo);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Customer found, retrieve details
                String fullName = rs.getString("fullname");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phonenumber");
                String accountType = rs.getString("accounttype");
                String dateOfBirth = rs.getString("dateofbirth");
                String idProof = rs.getString("idproof");
                String emailId = rs.getString("emailid");

                // Set customer details in request attributes
                request.setAttribute("fullName", fullName);
                request.setAttribute("address", address);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("accountType", accountType);
                request.setAttribute("dateOfBirth", dateOfBirth);
                request.setAttribute("idProof", idProof);
                request.setAttribute("emailId", emailId);

                request.getRequestDispatcher("customer-details.jsp").forward(request, response);
            } else {
                // Login failed
                response.sendRedirect("LoginFailure.html");
            }

        } catch (SQLException e) {
            throw new ServletException("Error communicating with database", e);
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
