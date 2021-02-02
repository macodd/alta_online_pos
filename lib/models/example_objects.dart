import 'customer.dart';
import 'product.dart';

/// ExampleCustomer
/// Test class
class ExampleCustomer {
  // test customer
  static Customer _exampleCustomer =
  Customer(
      "John Doe",
      "0924749146",
      "415-756-1890",
      "1230 Main st",
      "San Francisco, CA",
      "john_doe@mail.com"
  );

  // search function based on customer id
  static Customer searchCustomer(String clientID) {
    if (clientID == _exampleCustomer.id) {
      return _exampleCustomer;
    }
    return null;
  }
}

class ExampleProducts {

  static List<Product> products = [
    new Product("Budweiser", "sku001", unitPrice: 5.99, description: "American-style Lager"),
    new Product("Corona", "sku002", unitPrice: 5.99, description: "Even-keeled cerveza "),
    new Product("Stella", "sku003", unitPrice: 6.99, description: "Best-selling Belgian beer"),
    new Product("Heineken", "sku004", unitPrice: 6.99, description: "Beer. Made Better"),
    new Product("Drake's", "sku005", unitPrice: 7.99, description: "Hold my Hopoc")
  ];

  static int size() => products.length;

  static Product getProduct(int index) => products[index];
}