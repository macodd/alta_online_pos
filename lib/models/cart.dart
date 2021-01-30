import 'customer.dart';

// global payment methods
enum paymentMethod {QR, Card, Cash}

paymentMethod _paymentType;

void setPaymentType(paymentMethod pt) {
  _paymentType = pt;
}

paymentMethod getPaymentMethod() {
  return _paymentType;
}

class Order {

  static Customer _customer;
  static Cart cart = new Cart();

  static void clear() {
    _customer = null;
    cart = new Cart();
  }

  static void setCustomer(Customer customer) {
    _customer = customer;
  }

  static Customer getCustomer() => _customer;

}

class Cart {

  List<CartItem> _items;
  double _total;

  Cart() {
    _items = new List();
    _total = 0;
  }

  void addToCart(CartItem item) {
    _items.add(item);
  }

  double getTotal() => _total;

  int numOfItems() => _items.length;

  void removeLast() {
    _items.removeLast();
  }

  void addPrice(double price) {
    _items.last.setUnitPrice(price);
    _total += price;
  }

  CartItem getItem(int index) {
    return _items[index];
  }
}


class CartItem {

  String _name;
  int _quantity;
  String _sku;
  double _unitPrice;

  CartItem(this._name, this._quantity, this._sku);

  void setUnitPrice(double price) {
    _unitPrice = price;
  }

  double getUnitPrice() => _unitPrice;

  String getName() => _name;

  String getQuantity() => _quantity.toString();

  String getSku() => _sku;

  String getItemTotal() {
    return (_quantity * _unitPrice).toStringAsFixed(2);
  }
}





