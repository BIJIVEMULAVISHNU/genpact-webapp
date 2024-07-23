package withdraw;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/withdrawServlet")
public class withdrawServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String amountStr = request.getParameter("amount");
		String accNoStr = request.getParameter("accNo");
		String action = request.getParameter("action");

		try {
			int amount = Integer.parseInt(amountStr);
			int accNo = Integer.parseInt(accNoStr);

			boolean result = false;
			if ("withdraw".equals(action)) {
				result = withdrawDAO.withdraw(amount, accNo);
			} else if ("deposit".equals(action)) {
				result = withdrawDAO.deposit(amount, accNo);
			}

			response.setContentType("text/html");
			response.getWriter().println((action.equals("withdraw") ? "Withdrawal" : "Deposit") + " " + (result ? "successful" : "failed"));
		} catch (NumberFormatException e) {
			response.getWriter().println("Invalid input. Please enter numeric values.");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("An error occurred during the process.");
		}
	}
}
