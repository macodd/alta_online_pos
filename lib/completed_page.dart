import 'package:flutter/material.dart';

import 'models/order.dart';


class CompletedPage extends StatelessWidget {

  Widget displayTitle() {
    return Text(
      "Transaction complete!",
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget returnHomeButton(context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          "Done",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        onPressed: () {
          Order.clear();
          Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // TODO: Add image
            FlutterLogo(size: 100),
            displayTitle(),
            Text("Thank you for using Alta payment platform."),
            Text("Transaction ID: abx-123"),
            returnHomeButton(context),
          ],
        ),
      ),
    );
  }
}