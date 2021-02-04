import 'package:flutter/material.dart';

// models
import 'models/order.dart';
import 'models/customer.dart';

// navigator routes
import 'cash_page.dart';

class ClientInfoPage extends StatelessWidget {
  ClientInfoPage({key, this.customer}) : super(key: key);

  // customer information to show to user
  final Customer customer;

  // get the type of payment
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

  Widget displayTitle() {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        "Customer Information",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(Icons.edit),
      ),
    );
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

  Widget nextButton(context) {
    return FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          // set the customer for the order
          Order.setCustomer(customer);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => setPaymentRoute())
          );
        }
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
          displayTitle(),
          SizedBox(height: 10),
          customerInfo("Name :", customer.name),
          customerInfo("ID :", customer.id),
          customerInfo("Email", customer.email),
          customerInfo("Phone :", customer.phone),
          customerInfo("Address", customer.address),
          customerInfo("City", customer.city),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: nextButton(context),
    );
  }
}
