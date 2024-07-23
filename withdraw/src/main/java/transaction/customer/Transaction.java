package transaction.customer;

public class Transaction {
    private String transactionId;
    private String accountno;
    private String transactionType;
    private double amount;
    private java.sql.Date transactionDate;

    public Transaction(String transactionId, String accountno, String transactionType, double amount, java.sql.Date transactionDate) {
        this.transactionId = transactionId;
        this.accountno = accountno;
        this.transactionType = transactionType;
        this.amount = amount;
        this.transactionDate = transactionDate;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public String getAccountno() {
        return accountno;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public double getAmount() {
        return amount;
    }

    public java.sql.Date getTransactionDate() {
        return transactionDate;
    }
}
