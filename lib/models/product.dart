/// Product
/// Model used for a single item
class Product {
  // item information
  String name;
  String description;
  String sku;
  double unitPrice;

  // constructor
  Product(this.name, this.sku, {this.unitPrice, this.description});
}

/// Cart Item
class CartItem extends Product {

  int quantity;

  CartItem(String name, String sku, this.quantity) : super(name, sku);

  // returns quantity times unit price
  double getItemTotal() => quantity * unitPrice;
}