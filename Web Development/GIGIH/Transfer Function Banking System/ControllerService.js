const TransactionService = require('./TransactionService');

class ControllerService {
  constructor(transactionService, Customer) {
    this.customers = [];
    this.transactionService = transactionService;
    this.Customer = Customer;
  }
  createCustomer(customerId, name, email, balance) {
    const customer = new this.Customer(customerId, name, email, balance);
    this.customers.push(customer);
    return customer;
  }

  getCustomerById(customerId) {
    return this.customers.find(
      (customer) => customer.customerId === customerId
    );
  }

  getCustomerBalance(customerId) {
    const customer = this.getCustomerById(customerId);
    return customer ? customer.balance : null;
  }

  createTransaction(sourceId, destinationId, amount) {
    const sourceCustomer = this.getCustomerById(sourceId);
    const destinationCustomer = this.getCustomerById(destinationId);

    if (!sourceCustomer || !destinationCustomer) {
      throw new Error('Invalid source or destination customer ID');
    }

    if (sourceCustomer.balance < amount) {
      throw new Error('Insufficient balance');
    }

    sourceCustomer.balance -= amount;
    destinationCustomer.balance += amount;

    const transactionId = Math.random().toString(36).substr(2, 9);
    return this.transactionService.createTransaction(
      transactionId,
      sourceId,
      destinationId,
      amount
    );
  }

  getTransactionsByCustomerId(customerId) {
    return this.transactionService.getTransactionsByCustomerId(customerId);
  }
}

module.exports = ControllerService;
