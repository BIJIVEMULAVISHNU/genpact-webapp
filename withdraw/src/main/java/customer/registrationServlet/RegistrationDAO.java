package customer.registrationServlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RegistrationDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bankdb?useSSL=false";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    private static final Logger logger = Logger.getLogger(RegistrationDAO.class.getName());

    static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting database connection", e);
        }
        return conn;
    }

    public boolean registerCustomer(Customer customer) {
        boolean success = false;
        PreparedStatement stmt = null;
        Connection conn = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO accounts "
                    + "(accountno, fullname, address, phonenumber, accounttype, dateofbirth, idproof, emailid, password, balance) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql);

            // Set values for the prepared statement
            stmt.setLong(1, customer.getAccountNo());
            stmt.setString(2, customer.getFullName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getPhoneNumber());
            stmt.setString(5, customer.getAccountType());
            stmt.setString(6, customer.getDateOfBirth());
            stmt.setString(7, customer.getIdProof());
            stmt.setString(8, customer.getEmailId());
            stmt.setString(9, customer.getPassword());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                success = true;
            } else {
                logger.log(Level.WARNING, "No rows inserted when registering customer");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error inserting customer into database", e);
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Error closing resources", e);
            }
        }

        return success;
    }
}
