import 'package:flutter/material.dart';

// models
import 'models/order.dart';
import 'models/customer.dart';

// navigator routes
import 'cash_page.dart';

class ClientInfoPage extends StatelessWidget {
  // customer information to show to user
  final Customer _currCustomer = Order.getCustomer();

  final PaymentMethod _paymentType = Order.getPaymentMethod();

  // function to set the route based on the payment type
  setPaymentRoute() {
    var _route;
    switch (_paymentType) {
      case PaymentMethod.QR:
        _route = null;
        break;
      case PaymentMethod.Card:
        _route = null;
        break;
      case PaymentMethod.Cash:
        _route = CashPage();
        break;
    }
    return _route;
  }

  // General build widget to show information
  Widget customerInfo(String label, String customerInfo) {
    return PreferredSize(
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(label),
          subtitle: Text(customerInfo),
        ),
        preferredSize: Size.fromHeight(20),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
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
          customerInfo("Email", _currCustomer.email),
          customerInfo("Phone :", _currCustomer.phone),
          customerInfo("Address", _currCustomer.address),
          customerInfo("City", _currCustomer.city),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => setPaymentRoute())
          );
        }
      ),
    );
  }
}
