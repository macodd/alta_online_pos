import 'package:alta_online_pos/models/product.dart';

import '../models/customer.dart';
import '../models/product.dart';

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

  static Products _apiCall = new Products();

  static int counter = 0;

  static void callToApi() {
    _apiCall.addProduct(Product("Budweiser", "sku000", 5.99, description: "American-style Lager"));
    _apiCall.addProduct( Product("Corona", "sku001", 5.99, description: "Even-keeled cerveza "));
    _apiCall.addProduct( Product("Stella", "sku002", 6.99, description: "Best-selling Belgian beer"));
    _apiCall.addProduct( Product("Heineken", "sku003", 6.99, description: "Beer. Made Better"));
    _apiCall.addProduct( Product("Drake's", "sku004", 7.99, description: "Hold my Hopoc"));
  }

  static int getSize() => _apiCall.getSize();

  static Product getProduct(int index) => _apiCall.getProduct(index);

  static String getNextSKU() {
    int next = getSize() + counter;
    counter += 1;
    return "sku" + next.toString().padLeft(3, '0');
  }
}