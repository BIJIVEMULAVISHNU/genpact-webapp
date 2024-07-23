package customerDownload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/DownloadCustomerServlet")
public class DownloadCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountno");

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=customer_" + accountNo + ".csv");

        try (PrintWriter writer = response.getWriter()) {
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "root";
            
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                String sql = "SELECT * FROM accounts WHERE accountno = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, accountNo);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            writer.println("Account Number,Full Name,Address,Phone Number,Account Type,Date of Birth,ID Proof,Email ID");
                            writer.println(
                                rs.getString("accountno") + "," +
                                rs.getString("fullname") + "," +
                                rs.getString("address") + "," +
                                rs.getString("phonenumber") + "," +
                                rs.getString("accounttype") + "," +
                                rs.getString("dateofbirth") + "," +
                                rs.getString("idproof") + "," +
                                rs.getString("emailid")
                            );
                        } else {
                            writer.println("No data found for account number: " + accountNo);
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                writer.println("Error: " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
