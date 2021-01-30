import 'package:flutter/material.dart';

import 'models/cart.dart';
import 'models/customer.dart';


class ClientInfoPage extends StatelessWidget {

  final Customer _currCustomer = Order.getCustomer();

  Widget customerInfo(String label, String customerInfo) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(label),
      subtitle: Text(customerInfo),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              "Customer Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.edit),
            ),
          ),
          SizedBox(
            width: 100,
            child: Divider(),
          ),
          customerInfo("Name :", _currCustomer.name),
          customerInfo("ID :", _currCustomer.id),
          customerInfo("Phone :", _currCustomer.phone),
          customerInfo("Address", _currCustomer.address),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => _someClass)
          // );
          print("working..");
        }
      ),
    );
  }
}