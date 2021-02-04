import 'dart:collection';

import 'product.dart';

/// Cart
/// Stores the different items added by the user
/// and keeps track of the total to be paid
/// TODO: add max amount of items to be added to cart
class Cart {
  // list of items
  Map<String, CartItem> _items;
  // added total of unit price + quantity
  double _cartTotal;

  // constructor
  Cart() {
    _items = new SplayTreeMap();
    _cartTotal = 0;
  }

  // adds an item to the cart
  // if it already exist, subtract total,
  // update quantity, and update cart total
  void addToCart(String key, CartItem newItem) {
    if (_items.containsKey(key)) {
      _cartTotal -= _items[key].getItemTotal();
      _items[key].quantity += newItem.quantity;
      _cartTotal += _items[key].getItemTotal();
    }
    else {
      _items[key] = newItem;
      _cartTotal += newItem.getItemTotal();
    }
  }

  // gets the total
  double getTotal() => _cartTotal;

  // returns the amount of items in the cart
  int numOfItems() => _items.length;

  // removes the item at index
  void removeItem(String key) => _cartTotal -= _items.remove(key).getItemTotal();

  // returns a specific item at index location
  CartItem getItem(int index) => _items.values.elementAt(index);

}
