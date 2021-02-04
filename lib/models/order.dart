import 'customer.dart';
import 'cart.dart';

// global payment methods
enum PaymentMethod { QR, Card, Cash }

/// Order
/// Stores the customer information and the Cart
class Order {
  // Customer holder
  static Customer _customer;
  // Cart holder
  static Cart cart = new Cart();

  // payment type stored
  static PaymentMethod _paymentType;

  // return the total + 0.50 for transaction cost
  static double getTotal() {
    return cart.getTotal() + 0.5;
  }

  // clears the current order
  static void clear() {
    _customer = null;
    cart = new Cart();
    _paymentType = null;
  }

  // sets the payment type
  static void setPaymentType(PaymentMethod pt) {
    _paymentType = pt;
  }

  // gets the current payment type
  static PaymentMethod getPaymentMethod() {
    return _paymentType;
  }


  // sets a customer
  static void setCustomer(Customer customer) {
    _customer = customer;
  }

  // returns the customer
  static Customer getCustomer() => _customer;
}