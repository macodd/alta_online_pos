import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'examples/example_objects.dart';

// input price page
import 'price_page.dart';

// cart class
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

  // name text box
  final TextEditingController _nameController = TextEditingController();

  // item name and sku
  // quantity defaults to 1 for new items
  String _itemName;
  String _itemSKU = ExampleProducts.getNextSKU();
  final int _quantity = 1;

  // cleans the components when closed
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  /// display the title of the page
  Widget displayTitle() {
    return Text(
      "New Item",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  /// Text field for item name
  /// TODO: test length
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

  /// SKU input text field (optional)
  /// TODO: test length
  Widget itemSKUDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        "SKU : " + _itemSKU,
        style: TextStyle(
          color: Colors.grey
        ),
      )
    );
  }

  /*
   * Button to move to next page
   */
  Widget nextButton() {
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
            _formKey.currentState.save();
            // creates a new Cart item and adds it to the list
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => PriceInputPage(
                        newItem: new CartItem(_itemName, _itemSKU, 0.0, _quantity)
                    )
                )
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
            displayTitle(),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemNameInput(),
                  itemSKUDisplay(),
                  nextButton(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
