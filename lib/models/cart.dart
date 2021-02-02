import 'product.dart';

/// Cart
/// Stores the different items added by the user
/// and keeps track of the total to be paid
/// TODO: add max amount of items to be added to cart
class Cart {
  // list of items
  List<CartItem> _items;
  // added total of unit price + quantity
  double _total;

  // constructor
  Cart() {
    _items = new List();
    _total = 0;
  }

  // adds an item to the cart
  void addToCart(Product item) {
    _items.add(item);
  }

  // gets the total
  double getTotal() => _total;

  // returns the amount of items in the cart
  int numOfItems() => _items.length;

  // removes the last item added
  void removeLast() {
    _items.removeLast();
  }

  void removeLastPrice() {
    _total -= double.tryParse(_items.last.getItemTotal().toStringAsFixed(2));
  }

  /// adds a price to the last item added
  /// updates the total
  void addPrice(double price) {
    _items.last.unitPrice = price;
    _total += price;
  }

  // returns a specific item at index location
  CartItem getItem(int index) {
    return _items[index];
  }
}
