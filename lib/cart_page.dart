import 'package:flutter/material.dart';

// navigator pages
import 'start_page.dart';
import 'client_search_page.dart';

// classes
import 'models/order.dart';

/// Cart Page
/// Allows the users to see the final state
/// of the cart with its items and the total.
/// Allows users to keep adding items if necessary.
class CartPage extends StatefulWidget {
  CartPage({key, this.previousSKU}) : super(key: key);

  final String previousSKU;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  double _orderTotal;

  @override
  void initState() {
    super.initState();
    _orderTotal = Order.getTotal();
  }

  Widget displayTitle() {
    return Text(
      "Cart",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  Widget displayList() {
    return Expanded(
        child: ListView.builder(
          itemCount: Order.cart.numOfItems(),
          itemBuilder: (context, index) {
            final item = Order.cart.getItem(index);
            return Dismissible(
              key: Key(item.sku),
              onDismissed: (direction) {
                setState(() {
                  Order.cart.removeItem(item.sku);
                  _orderTotal = Order.getTotal();
                });
                // Then show a snackbar.
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )
                      ),
                      content: Text(item.name + " removed"))
                );
              },
              background: Container(color: Colors.red),
              child: ListTile(
                  title: Text(item.name),
                  subtitle: Text("Qty: " + item.quantity.toString()),
                  trailing: Text(item.getItemTotal().toStringAsFixed(2))
              )
            );
          },
        )
    );
  }

  Widget confirmOrAddMoreButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.add, size: 16)
                  ),
                  Text("add more items"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StartPage()) //client
                );
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Total: \$ " + _orderTotal.toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                  Text(
                    " -\t Continue?",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                if (Order.getTotal() < 11) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                          )
                        ),
                        content: Text("Amount must be \$ 11.00 or higher"))
                  );
                }
                else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientSearchPage()) //client
                  );
                }
              },
            ),
          ],
        );
      }),
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
              Order.cart.removeItem(widget.previousSKU);
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
            displayList(), // builder to show all items
          ],
        )
      ),
      bottomNavigationBar: confirmOrAddMoreButtons()
    );
  }
}
