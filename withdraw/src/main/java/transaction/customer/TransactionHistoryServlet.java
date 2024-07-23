package transaction.customer;

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

@WebServlet("/viewTransactions")
public class TransactionHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        String errorMessage = null;
        String successMessage = null;
        
        // Initialize database connection objects
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
            
            // Create SQL query
            String sql = "SELECT transaction_id, accountno, transaction_type, amount, transaction_date, balance FROM transactions WHERE accountno = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, accountno);
            rs = pstmt.executeQuery();
            
            // Check if transactions exist
            if (!rs.next()) {
                errorMessage = "No transactions found for the given account number.";
            } else {
                rs.beforeFirst(); // Move cursor back to the start
            }
            
            // Store transaction results in request attributes
            request.setAttribute("transactionResultSet", rs);
            request.setAttribute("accountno", accountno);
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            errorMessage = "Error loading database driver: " + e.getMessage();
        } catch (SQLException e) {
            e.printStackTrace();
            errorMessage = "SQL error: " + e.getMessage();
        } finally {
            // Close ResultSet, PreparedStatement, and Connection
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        
        // Set error or success message
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("successMessage", successMessage);
        
        // Forward the request to the JSP page
        request.getRequestDispatcher("viewTransactions.jsp").forward(request, response);
    }
}
