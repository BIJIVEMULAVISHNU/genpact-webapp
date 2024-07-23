package AdminServlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerDAO {

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/bankdb";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    // Method to get admin name based on username and password
    public String getAdminName(String username, String password) throws Exception {
        String adminName = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish database connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL query to check credentials
            String sql = "SELECT * FROM admin WHERE fullname = ? AND password = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username); // Use adminID for username
            statement.setString(2, password); // Use adminPassword for password

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                adminName = resultSet.getString("fullname");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error while validating admin credentials");
        } finally {
            // Close resources
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }

        return adminName;
    }
}
