const Transaction = require('./Transaction');

class TransactionService {
  constructor(Transaction) {
    this.transactions = [];
    this.Transaction = Transaction;
  }

  createTransaction(transactionId, sourceId, destinationId, amount) {
    const timestamp = new Date();
    const transaction = new this.Transaction(
      transactionId,
      sourceId,
      destinationId,
      amount,
      timestamp
    );
    this.transactions.push(transaction);
    return transaction;
  }

  getTransactionsByCustomerId(customerId) {
    return this.transactions.filter(
      (transaction) =>
        transaction.sourceId === customerId ||
        transaction.destinationId === customerId
    );
  }
}

module.exports = TransactionService;
