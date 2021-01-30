import 'package:flutter/material.dart';

// used pages
import 'start_page.dart';
import 'client_search_page.dart';

// classes
import 'models/cart.dart';

class CartPage extends StatelessWidget {
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
            Text(
              "Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(
              width: 100,
              child: Divider(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Order.cart.numOfItems(),
                itemBuilder: (context, index) {
                  final listItem = Order.cart.getItem(index);
                  return ListTile(
                    title: Text(listItem.getName()),
                    subtitle: Text("Qty: " + listItem.getQuantity()),
                    trailing: Text(listItem.getItemTotal()),
                  );
                },
              )
            ),
            SizedBox(height: 100),
          ],
        )
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.add, size: 16)),
                  Text("add more items"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChargePage())  //client
                );
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Total: \$ " + Order.cart.getTotal().toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  Text(
                    " -\t Continue?",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientSearchPage())  //client
                );
              },
            ),
          ],
        )
      )
    );
  }
}