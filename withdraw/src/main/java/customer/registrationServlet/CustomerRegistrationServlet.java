package customer.registrationServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Random;

@WebServlet("/CustomerRegistrationServlet")
public class CustomerRegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phonenumber");
        String accountType = request.getParameter("accounttype");
        String dateOfBirth = request.getParameter("dateofbirth");
        String idProof = request.getParameter("idproof");
        String emailId = request.getParameter("emailid");
        
        // Generate a random password and account number
        String password = generateRandomPassword();
        int accountNo = generateAccountNumber();

        try {
            // Ensure the driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&allowPublicKeyRetrieval=true", "root", "root");
            RegistrationDAO registrationDAO = new RegistrationDAO();

            Customer customer = new Customer();
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setPhoneNumber(phoneNumber);
            customer.setAccountType(accountType);
            customer.setDateOfBirth(dateOfBirth);
            customer.setIdProof(idProof);
            customer.setEmailId(emailId);
            customer.setPassword(password);
            customer.setAccountNo(accountNo);

            boolean success = registrationDAO.registerCustomer(customer);

            if (success) {
                // Set attributes to pass to the success page
                request.setAttribute("accountNo", accountNo);
                request.setAttribute("password", password);
                request.getRequestDispatcher("register-success.jsp").forward(request, response);
            } else {
                response.sendRedirect("register.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error communicating with database", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to registration form or show an appropriate message
        response.sendRedirect("register.jsp");
    }

    private String generateRandomPassword() {
        int length = 8;
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private int generateAccountNumber() {
        // Implement logic to generate a unique account number
        // This can be a random number generator or a sequence from the database
        return (int) (Math.random() * 1000000); // Example implementation
    }
}
