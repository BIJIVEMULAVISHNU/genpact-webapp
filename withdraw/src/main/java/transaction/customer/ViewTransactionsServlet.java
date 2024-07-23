package transaction.customer;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewTransactionsServlet")
public class ViewTransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Transaction> transactions = new ArrayList<>();
        
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String username = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT * FROM transactions";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String transactionId = resultSet.getString("transaction_id");
                String accountno = resultSet.getString("accountno");
                String transactionType = resultSet.getString("transaction_type");
                double amount = resultSet.getDouble("amount");
                java.sql.Date transactionDate = resultSet.getDate("transaction_date");

                Transaction transaction = new Transaction(transactionId, accountno, transactionType, amount, transactionDate);
                transactions.add(transaction);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        for (Transaction t : transactions) {
            System.out.println(t.getTransactionId() + " " + t.getAccountno() + " " + t.getTransactionType() + " " + t.getAmount() + " " + t.getTransactionDate());
        }

        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("view-transactions.jsp").forward(request, response);
    }
}
