import 'package:flutter/material.dart';

import 'models/example_objects.dart';
import 'models/product.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ProductsListPage> {

  Future<void> _showMyDialog(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.name, textAlign: TextAlign.center),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quantity", textAlign: TextAlign.center),

            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok', textAlign: TextAlign.end),
              onPressed: () {
                Navigator.pop(context);
              }
            )
          ],
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
            Text(
              "Products",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 32
              ),
            ),
            SizedBox(
              width: 100,
              child: Divider(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ExampleProducts.size(),
                itemBuilder: (context, index) {
                  final product = ExampleProducts.getProduct(index);
                  return Card(
                    child: InkWell(
                      splashColor: Colors.green,
                      onTap: () {
                        print("Card tapped..");
                        _showMyDialog(product);
                      },
                      child: ListTile(
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
            ),
        ])
      ),
    );
  }
}
