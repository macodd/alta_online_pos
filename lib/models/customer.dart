
class Customer {

  String name;
  String id;
  String phone;
  String address;

  Customer(this.name, this.id, this.phone, this.address);
}

class ExampleCustomer {

  static Customer _exampleCustomer = Customer(
        "John Doe",
        "0924749146",
        "123-456-7890",
        "Somewhere, US"
    );

  static Customer searchCustomer(String clientID) {
    if (clientID == _exampleCustomer.id) {
      return _exampleCustomer;
    }
    return null;
  }

}