const TransactionService = require('./TransactionService');
const ControllerService = require('./ControllerService');
const Customer = require('./Customer');
const Transaction = require('./Transaction');

// Usage example
const transactionService = new TransactionService(Transaction);
const controllerService = new ControllerService(transactionService, Customer);


const customer1 = controllerService.createCustomer(
  '001',
  'John Doe',
  'john@example.com',
  5000
);

const customer2 = controllerService.createCustomer(
  '002',
  'Jane Smith',
  'jane@example.com',
  3000
);

controllerService.createTransaction('001', '002', 1000);

console.log(controllerService.getCustomerBalance('001')); // Output: 4000
console.log(controllerService.getCustomerBalance('002')); // Output: 4000

const customer1Transactions = controllerService.getTransactionsByCustomerId(
  '001'
);
console.log(customer1Transactions); // Output: [Transaction object]

const customer2Transactions = controllerService.getTransactionsByCustomerId(
  '002'
);
console.log(customer2Transactions); // Output: [Transaction object]
