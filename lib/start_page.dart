import 'package:flutter/material.dart';

// local pages
import 'new_item_page.dart';

// payment type
import 'models/cart.dart';

class ChargePage extends StatefulWidget {
  @override
  _ChargePageState createState() => _ChargePageState();
}

class _ChargePageState extends State<ChargePage> {

  // type of payment
  final paymentMethod paymentType = getPaymentMethod();

  // icon to show user based on previous selection
  // TODO: show image instead of Icon
  Icon _icon;

  @override
  void initState() {
    super.initState();
    double _size = 50;
    // select which icon to show
    switch(paymentType) {
      case paymentMethod.QR:
        _icon = Icon(Icons.qr_code_outlined, size: _size);
        break;
      case paymentMethod.Card:
        _icon = Icon(Icons.credit_card_outlined, size: _size);
        break;
      case paymentMethod.Cash:
        _icon = Icon(Icons.attach_money_outlined, size: _size);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    // widget to re route base on selection
    Widget itemSelector(_text, _someClass) {
      return SizedBox(
        width: 150,
        height: 50,
        child: OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Text(_text),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _someClass)
              );
            }
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
            padding: const EdgeInsets.all(10),
            child: BackButton(
              color: Colors.black,
              onPressed: () {
                Order.clear();
                Navigator.popAndPushNamed(context, '/main');
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
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 100,
                child: _icon,
              ),
              itemSelector("New Item", NewItemPage()),
              SizedBox(
                width: 100,
                child: Divider(height: 40),
              ),
              itemSelector("Select Items", null)
            ],
          ),
        ]
      ),
    );
  }
}