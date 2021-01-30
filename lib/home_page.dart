import 'package:alta_online_pos/start_page.dart';
import 'package:flutter/material.dart';

// local
import 'price_page.dart';

// user profile
import 'models/cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  // button colors
  Color _color1, _color2, _color3 = Colors.blueGrey;

  paymentMethod _paymentType;

  Widget qrButton() {
    return Column(
      children: [
        SizedBox(
          height: 84,
          width: 84,
          child: FloatingActionButton(
              heroTag: "qrBtn",
              backgroundColor: _color1,
              child: Icon(Icons.qr_code_outlined),
              onPressed: () {
                setState(() {
                  if (_color1 == Colors.green) {
                    _color1 = Colors.blueGrey;
                  }
                  else {
                    _color1 = Colors.green;
                    _color2 = Colors.blueGrey;
                    _color3 = Colors.blueGrey;

                    _paymentType = paymentMethod.QR;
                  }
                });
              }
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "QR Code",
              style: TextStyle(
                  fontSize: 12
              ),
            )
        )
      ],
    );
  }

  Widget ccButton() {
    return Column(
      children: [
        SizedBox(
          height: 84,
          width: 84,
          child: FloatingActionButton(
              heroTag: "ccBtn",
              backgroundColor: _color2,
              child: Icon(Icons.credit_card_outlined),
              onPressed: () {
                setState(() {
                  if (_color2 == Colors.green) {
                    _color2 = Colors.blueGrey;
                  }
                  else {
                    _color2 = Colors.green;
                    _color1 = Colors.blueGrey;
                    _color3 = Colors.blueGrey;

                    _paymentType = paymentMethod.Card;
                  }
                });
              }
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Credit Card",
              style: TextStyle(
                  fontSize: 12
              ),
            )
        )
      ],
    );
  }

  Widget cashButton() {
    return Column(
      children: [
        SizedBox(
          height: 84,
          width: 84,
          child: FloatingActionButton(
              heroTag: "mBtn",
              backgroundColor: _color3,
              child: Icon(Icons.attach_money_outlined),
              onPressed: () {
                setState(() {
                  if (_color3 == Colors.green) {
                    _color3 = Colors.blueGrey;
                  }
                  else {
                    _color3 = Colors.green;
                    _color1 = Colors.blueGrey;
                    _color2 = Colors.blueGrey;

                    _paymentType = paymentMethod.Cash;
                  }
                });
              }
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Cash",
              style: TextStyle(
                  fontSize: 12
              ),
            )
        )
      ],
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
            child: FlutterLogo()
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(Icons.account_circle_outlined, color: Colors.black),
                    ),
                    // Text(AltaUser.getName(), style: TextStyle(color: Colors.black),)
                    Text("Mark Codd", style: TextStyle(color: Colors.black),)
                  ],
                )
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        child: Card(
          elevation: 10.0,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      qrButton(),
                      ccButton(),
                      cashButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white)
                      ),
                      onPressed: () {
                        if(_paymentType != null) {
                          setPaymentType(_paymentType);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChargePage()
                            ),
                          );
                        }
                      },
                    ),
                  )
                ),
              ],
            )
          ),
        )
      )
    );
  }
}