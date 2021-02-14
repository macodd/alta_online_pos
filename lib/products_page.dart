import 'package:flutter/material.dart';

import 'examples/example_objects.dart';
import 'models/product.dart';
import 'models/order.dart';

import 'cart_page.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ProductsListPage> {

  void _showMyDialog(Product product) async {
    showDialog(
      context: context,
      builder: (context) {
        // counter for quantity to be added to product
        int counter = 1;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            actionsPadding: const EdgeInsets.all(10),
            title: Text(
                product.name,
                textAlign: TextAlign.center
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(),
                ),
                Text("Quantity", textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      child: Icon(Icons.remove),
                      onPressed: () {
                        if(counter > 1) {
                          setState(() {
                            counter -= 1;
                          });
                        }
                      }
                    ),
                    Text(
                      counter.toString(),
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    FlatButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          if(counter < 5) {
                            setState(() {
                              counter += 1;
                            });
                          }
                        }
                    ),
                  ],
                )
              ],
            ),
            actions: [
              SizedBox(
                height: 50,
                width: 100,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  color: Colors.blue,
                  child: Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 16
                      )
                  ),
                  onPressed: () {
                    Order.cart.addToCart(
                      product.sku,
                      new CartItem(
                        product.name,
                        product.sku,
                        product.unitPrice,
                        counter
                      )
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(previousSKU: product.sku)
                      )
                    );
                  }
                )
              )
            ],
          );
        });
      },
    );
  }

  Widget displayTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Products",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32
        ),
      )
    );
  }

  Widget productsList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: ExampleProducts.getSize(),
        itemBuilder: (context, index) {
          final product = ExampleProducts.getProduct(index);
          return Card(
            child: InkWell(
              splashColor: Colors.green,
              onTap: () {
                _showMyDialog(product);
              },
              child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    product.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(product.description),
                  trailing: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      product.unitPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                  )
              ),
            ),
          );
        },
      )
    );
  }

  Widget nextButton() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      child: Icon(Icons.arrow_forward),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage())
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
            padding: const EdgeInsets.all(10),
            child: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FlutterLogo(),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            displayTitle(),
            SizedBox(height: 10),
            productsList(),
          ]
        )
      ),
      floatingActionButton: nextButton()
    );
  }
}
