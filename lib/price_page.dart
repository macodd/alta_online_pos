import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// next page
import 'cart_page.dart';

// cart class
import 'models/order.dart';
import 'models/product.dart';

/// Price Input Page
/// Allows the users to input a price between 10 and 500
/// to be defined as the items unit price.
/// The user can see the total amount of the
/// price + 5% for the service
class PriceInputPage extends StatefulWidget {
  PriceInputPage({key, this.newItem}) : super(key: key);

  final CartItem newItem;

  @override
  _PriceInputPageState createState() => _PriceInputPageState();
}

/// Price Input Page
/// Allows the users to input a price between 10 and 500
/// to be defined as the items unit price.
/// The user can see the total amount of the
/// price + 5% for the service
/// Stateful for transforming int to double and show
/// it to the user
class _PriceInputPageState extends State<PriceInputPage> {
  // store the payment type on the widget
  final PaymentMethod paymentType = Order.getPaymentMethod();

  // total after extra cost displayed to user
  double _totalAmount = 0;
  // amount displayed to the user with 2 decimal points
  double _displayAmount = 0;

  // Error message
  String _errorMsg = "";

  final int minAmount = 100;

  // max amount allowed to input
  final int maxAmount = 50000;

  // controller used for validating input from user
  final TextEditingController _amountController = TextEditingController();
  // key used for validating the amount form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Icon to show the type of transaction being perform
  Icon _paymentMethodIcon;

  @override
  void initState() {
    super.initState();
    // handle the type of Icon to be displayed
    switch (paymentType) {
      case PaymentMethod.QR:
        _paymentMethodIcon = Icon(Icons.qr_code_outlined);
        break;
      case PaymentMethod.Card:
        _paymentMethodIcon = Icon(Icons.credit_card_outlined);
        break;
      case PaymentMethod.Cash:
        _paymentMethodIcon = Icon(Icons.attach_money_outlined);
        break;
    }
  }

  ///
  /// dispose of controllers
  ///
  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  ///
  /// Title displayed to the user
  ///
  Widget displayTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _paymentMethodIcon,
          ),
          Text("Amount", style: TextStyle(fontSize: 18)),
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

  /// Displays the total along with
  /// the 5% for the use of the service
  Widget displayTotal() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
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

  /// Function to check changes on the text controller
  /// it changes state of:
  /// - error messages
  /// - displayed amount
  /// - total amount
  void inputAmountChanged(value) {
    // convert the value into a string
    int amount = int.tryParse(value);
    double displayA = 0;
    double totalA = 0;

    // error message holder
    String _error = "";

    if (value == "" || amount == null) {
      amount = 0;
    }
    else {
      displayA = amount / 100;
      if (amount < minAmount) {
        totalA = displayA;
      }
      else if (amount > maxAmount) {
        totalA = displayA;
        _error = "Amount can't exceed 500.00";
      }
      else {
        totalA = displayA + (displayA * 0.05);
      }
    }
    setState(() {
      _displayAmount = displayA;
      _totalAmount = totalA;
      _errorMsg = _error;
    });
  }

  /// Function to validate the value of the controller
  String validateInputAmount(String value) {
    // value comes as an integer
    int amount = int.tryParse(value);

    if (value == '' || value == null) {
      setState(() {
        _errorMsg = "Amount can't be 0";
      });
      return "No input";
    }
    // amount less than minimum
    if (amount < minAmount) {
      setState(() {
        _errorMsg = "Amount can't be under 1.00";
      });
      return "under 1.00";
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

  ///
  /// Text input hidden from user to input
  /// amount in integer form
  ///
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

  Widget submitButton() {
    return SizedBox(
      height: 50,
      width: 200,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.blue,
        child: Text(
          "Continue",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // add the price of the last item to the list
            widget.newItem.unitPrice =
                double.parse(_totalAmount.toStringAsFixed(2));
            // add item to list in order
            Order.cart.addToCart(widget.newItem.sku, widget.newItem);
            // push to next page
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => CartPage(previousSKU: widget.newItem.sku))
            );
          }
        }
      ),
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              displayErrorMessage(),  // Error message displayed to user if any
              displayTitle(),  // displays the title along with icon
              // Amount to show with Text editor on top
              // in case the user dismisses the keyboard but wants
              // to call it back
              Stack(
                fit: StackFit.loose,
                children: [
                  // Shows amount in decimal form
                  displayAmount(),
                  // call to keyboard
                  amountInput()
                ],
              ),
              displayTotal(),  // Shows total after calculating extra costs
              SizedBox(height: 30),
              submitButton(),   // show the bottom button
            ]
          )
        ),
      ),
    );
  }
}
