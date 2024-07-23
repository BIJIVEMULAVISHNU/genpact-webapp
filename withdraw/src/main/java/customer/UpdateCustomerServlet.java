package customer;

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

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phonenumber = request.getParameter("phonenumber");
        String accounttype = request.getParameter("accounttype");
        String dateofbirth = request.getParameter("dateofbirth");
        String idproof = request.getParameter("idproof");
        String emailid = request.getParameter("emailid");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // Create SQL statement
            String sql = "UPDATE accounts SET fullname=?, address=?, phonenumber=?, accounttype=?, dateofbirth=?, idproof=?, emailid=? WHERE accountno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fullname);
            pstmt.setString(2, address);
            pstmt.setString(3, phonenumber);
            pstmt.setString(4, accounttype);
            pstmt.setString(5, dateofbirth);
            pstmt.setString(6, idproof);
            pstmt.setString(7, emailid);
            pstmt.setString(8, accountno);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("customerDetails.jsp?message=Customer details updated successfully");
            } else {
                response.sendRedirect("customerDetails.jsp?error=Failed to update customer details");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("customerDetails.jsp?error=Error loading database driver: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerDetails.jsp?error=SQL error: " + e.getMessage());
        } finally {
            // Close PreparedStatement and Connection
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
