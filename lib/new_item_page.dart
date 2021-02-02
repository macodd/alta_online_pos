import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// input price page
import 'price_page.dart';

// cart class
import 'models/order.dart';
import 'models/product.dart';

/// New Item page
/// Allows users to input a new item.
/// Users are required to input a name, SKU is optional
class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

/// New Item page
/// Allows users to input a new item.
/// Users are required to input a name, SKU is optional
/// Stateful to show error messages
class _NewItemPageState extends State<NewItemPage> {
  // form key
  final GlobalKey<FormState> _formKey = new GlobalKey();

  // email text box
  final TextEditingController _nameController = TextEditingController();

  // email text box
  final TextEditingController _skuController = TextEditingController();

  // item name and sku
  // quantity defaults to 1 for new items
  String _itemName;
  String _itemSKU;
  final int _quantity = 1;

  // cleans the components when closed
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _skuController.dispose();
  }

  /*
   * Text field for item name
   * TODO: test length
   */
  Widget itemNameInput() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(16)],
      onSaved: (val) {
        _itemName = val;
      },
      validator: (val) {
        if (val.isEmpty || val.length < 3) {
          return 'Please enter a valid name';
        }
        return null;
      },
    );
  }

  /*
   * SKU input text field (optional)
   * TODO: test length
   */
  Widget itemSKUInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: TextFormField(
        controller: _skuController,
        decoration: const InputDecoration(
          labelText: 'SKU (optional)*',
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        onSaved: (val) {
          _itemSKU = val == null ? "" : val;
        },
        validator: (val) {
          return null;
        },
      )
    );
  }

  /*
   * Button to move to next page
   */
  Widget nextButton() {
    return Container(
      height: 50,
      width: 150,
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
            _formKey.currentState.save();
            // creates a new Cart item and adds it to the list
            Order.cart.addToCart(
                new CartItem(_itemName, _itemSKU, _quantity)
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PriceInputPage())
            );
          }
        },
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
            )),
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
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "New Item",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemNameInput(),
                  itemSKUInput(),
                  nextButton()
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
