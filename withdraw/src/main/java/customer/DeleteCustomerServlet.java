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

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "root");

            String sql = "DELETE FROM accounts WHERE accountno = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountno);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("customerDetails.jsp?message=Customer+deleted+successfully");
            } else {
                response.sendRedirect("customerDetails.jsp?error=Customer+not+found");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("customerDetails.jsp?error=Error+loading+database+driver");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerDetails.jsp?error=SQL+error:" + e.getMessage());
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
