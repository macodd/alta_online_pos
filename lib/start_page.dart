import 'package:flutter/material.dart';

// next page
import 'new_item_page.dart';
import 'products_page.dart';

// payment type
import 'models/order.dart';

/// StartPage
/// Page that allows the user to select which
/// type of item they wish to input (new item, old item)
class StartPage extends StatelessWidget {
  // type of payment
  final PaymentMethod paymentType = Order.getPaymentMethod();

  // icon to show user based on previous selection
  // TODO: show image instead of Icon
  Widget initIconState() {
    Icon icon;
    double _size = 50;
    // select which icon to show
    switch (paymentType) {
      case PaymentMethod.QR:
        icon = Icon(Icons.qr_code_outlined, size: _size);
        break;
      case PaymentMethod.Card:
        icon = Icon(Icons.credit_card_outlined, size: _size);
        break;
      case PaymentMethod.Cash:
        icon = Icon(Icons.attach_money_outlined, size: _size);
        break;
    }
    return icon;
  }

  Widget customDivider() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: Divider(),
      ),
    );
  }

  // TODO make image
  Widget displayImage() {
    return SizedBox(
      height: 150,
      child: initIconState(),
    );
  }


  @override
  Widget build(BuildContext context) {
    // widget to re route base on selection
    Widget itemSelector(_text, _someClass) {
      return SizedBox(
        width: 150,
        height: 50,
        child: OutlineButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(_text),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => _someClass));
            }),
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
                // clears any current orders
                Order.clear();
                // pushes to main without allowing to go back to previous
                // screens
                Navigator.popAndPushNamed(context, '/main');
              },
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FlutterLogo(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              displayImage(),
              itemSelector("New Item", NewItemPage()),
              customDivider(),
              itemSelector("Select Items", ProductsListPage())
            ],
          ),
        )
      ),
    );
  }
}
