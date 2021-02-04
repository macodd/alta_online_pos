/// Product
/// Model used for a single item
class Product {
  // item information
  String name;
  String description;
  String sku;
  double unitPrice;

  // constructor
  Product(this.name, this.sku, this.unitPrice, {this.description});
}

/// Cart Item
class CartItem extends Product {

  int quantity;

  CartItem(String name, String sku, double price, this.quantity, ) : super(name, sku, price);

  // returns quantity times unit price
  double getItemTotal() => quantity * unitPrice;
}

class Products {

  List<Product> products;

  Products() {
    products = new List();
  }

  void addProduct(Product p) => products.add(p);

  Product getProduct(int index) => products[index];

  int getSize() => products.length;
}