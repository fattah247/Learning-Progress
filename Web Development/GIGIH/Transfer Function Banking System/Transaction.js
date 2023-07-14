// Transaction.js
class Transaction {
    constructor(transactionId, sourceId, destinationId, amount, timestamp) {
      this.transactionId = transactionId;
      this.sourceId = sourceId;
      this.destinationId = destinationId;
      this.amount = amount;
      this.timestamp = timestamp;
    }
  }
  
  module.exports = Transaction;
  