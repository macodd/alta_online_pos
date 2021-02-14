import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'models/order.dart';

import 'completed_page.dart';

class CashPage extends StatefulWidget {
  @override
  _CashPageState createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {

  // total after extra cost displayed to user
  double _totalAmount = Order.cart.getTotal();
  // amount displayed to the user with 2 decimal points
  double _displayAmount = 0;

  double _displayChange = 0;

  // Error message
  String _errorMsg = "";

  // max amount allowed to input
  final int maxAmount = 50000;

  // controller used for validating input from user
  final TextEditingController _amountController = TextEditingController();
  // key used for validating the amount form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// dispose of controllers
  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  /// Title displayed to the user
  Widget displayTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cash Received", style: TextStyle(fontSize: 18)),
        ],
      )
    );
  }

  Widget amountInputForm() {
    return  Form(
      key: _formKey,
      child: Stack(
        fit: StackFit.loose,
        children: [
          // Shows amount in decimal form
          displayAmount(),
          // call to keyboard
          amountInput()
        ],
      ),
    );
  }

  /// Displays error messages
  Widget displayErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _errorMsg,
            style: TextStyle(color: Colors.red),
          )
        ],
      )
    );
  }

  /// Displays the amount in decimal format
  /// fixed with 2 decimal places and rounded up.
  Widget displayAmount() {
    return Card(
      elevation: 10.0,
      color: Colors.white,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "\$ " + _displayAmount.toStringAsFixed(2),
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
    );
  }

  /// Displays the total along with
  /// the 5% for the use of the service
  Widget displayTotal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total :",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            )
          ),
          Text(
            _totalAmount.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            )
          ),
        ],
      ),
    );
  }

  /// Displays the total along with
  /// the 5% for the use of the service
  Widget displayChange() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Change :",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            )
          ),
          Text(
            _displayChange.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            )
          ),
        ],
      ),
    );
  }

  /// Function to check changes on the text controller
  /// it changes state of:
  /// - error messages
  /// - displayed amount
  /// - total amount
  void inputAmountChanged(value) {
    // convert the value into a string
    int amount = int.tryParse(value);
    double displayAmount = 0;
    double displayChange = 0;

    // error message holder
    String _error = "";

    if (amount == null) {
      amount = 0;
    }
    else {
      displayAmount = amount / 100;
      double tot = displayAmount - _totalAmount;
      if (tot > 0) {
        displayChange = tot;
      }
    }
    setState(() {
      _displayAmount = displayAmount;
      _displayChange = displayChange;
      _errorMsg = _error;
    });
  }

  /// Function to validate the value of the controller
  String validateInputAmount(String value) {
    // value comes as an integer
    int amount = int.tryParse(value);

    if (amount == null) {
      setState(() {
        _errorMsg = "Amount could not be processed";
      });
      return "No input";
    }

    // amount less than minimum
    if ((amount/100) < _totalAmount) {
      setState(() {
        _errorMsg = "Amount can't be less than the total";
      });
      return "under total amount";
    }
    // amount more than maximum
    if (amount > maxAmount) {
      setState(() {
        _errorMsg = "Amount can't exceed 500.00";
      });
      return "exceeded 500.00";
    }
    return null;
  }

  /// Text input hidden from user to input
  /// amount in integer form
  Widget amountInput() {
    return Opacity(
      opacity: 0.0,
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: TextFormField(
          autofocus: true,
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          onChanged: inputAmountChanged,
          // validator for text editor
          validator: validateInputAmount,
        )
      )
    );
  }

  void confirmed() {
    if (_formKey.currentState.validate()) {
      new Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context)=> CompletedPage()),
            ModalRoute.withName("/main")
        );
      });
    }
  }

  Widget confirmButton() {
    return ConfirmationSlider(
      backgroundColor: Colors.white,
      backgroundColorEnd: Colors.blue,
      foregroundColor: Colors.blue,
      icon: Icons.double_arrow_outlined,
      shadow: BoxShadow(color: Colors.white),
      text: "Slide to complete",
      backgroundShape: BorderRadius.circular(25),
      onConfirmation: confirmed
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            displayErrorMessage(),  // Error message displayed to user if any
            displayTitle(),  // displays the title along with icon
            // Amount to show with Text editor on top
            // in case the user dismisses the keyboard but wants
            // to call it back
            amountInputForm(),
            displayTotal(),   // Shows total after calculating extra costs
            displayChange(),  // shows the change to give back
            SizedBox(height: 20),
            confirmButton()
          ]
        )
      ),
    );
  }
}
