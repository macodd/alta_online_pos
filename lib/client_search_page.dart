import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// navigator page
import 'client_info_page.dart';

// models used
import 'models/order.dart';
import 'models/customer.dart';

import 'examples/example_objects.dart';

/// Search class that allows users to search the database
/// for previously registered customers.
class ClientSearchPage extends StatefulWidget {
  @override
  _ClientSearchPageState createState() => _ClientSearchPageState();
}

/// Search class that allows users to search the database
/// for previously registered customers.
/// Stateful to show message of found/not found
class _ClientSearchPageState extends State<ClientSearchPage> {
  // search field editor
  final TextEditingController _searchField = TextEditingController();

  // form key
  final GlobalKey<FormState> _searchFormKey = new GlobalKey();

  // client id used for search
  String _clientID;

  // widget to show if customer is found
  Widget _showSearchResult;

  // used for changing focus after keyboard entry
  FocusNode _focusNode;

  // create a new focus node
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  // dispose of controller and focus node
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _searchField.dispose();
  }

  ///
  /// Validator for text field
  ///
  String _clientValidation(String val) {
    // regex for only digits
    RegExp _digits = RegExp(r'^[0-9]+$');
    print(val.length);
    // validators
    if ((val.length == 10 || val.length == 13) && _digits.hasMatch(val)) {
      return null;
    }
    return "Invalid ID";
  }

  Widget displayTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Client ID Search",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32
        ),
      )
    );
  }

  Widget searchForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _searchFormKey,
        child: TextFormField(
          controller: _searchField,
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_outlined),
            fillColor: Colors.transparent,
            hintText: "Search",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            )
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13)
          ],
          onSaved: (val) {
            _clientID = val;
          },
          validator: _clientValidation,
        ),
      )
    );
  }

  // widget to re route base on selection
  Widget searchButton() {
    return Container(
      width: 200,
      height: 50,
      child: RaisedButton(
          color: Colors.blue,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Text(
            "Search",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _focusNode.unfocus();
            if (_searchFormKey.currentState.validate()) {
              _searchFormKey.currentState.save();
              Customer _customer = ExampleCustomer.searchCustomer(_clientID);
              showFoundClient(_customer);
            }
          }
      ),
    );
  }

  /// shows the user if the customer is in the database
  void showFoundClient(Customer _customer) {
    // widget to store search result
    Widget _result;

    if (_customer != null) {
      _result = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Customer Found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.person)),
                    title: Text(_customer.name),
                    subtitle: Text(_customer.id),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientInfoPage(customer: _customer)
                  )
              );
            },
          )
        ],
      );
    } else {
      _result = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "No Customer Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ]
      );
    }
    // set the state of the show result widget
    setState(() {
      _showSearchResult = _result;
    });
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
                Order.clear();
                // TODO: fix to show before navigating to other page
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            displayTitle(),
            SizedBox(height: 10),
            searchForm(),
            SizedBox(height: 16),
            searchButton(),
            SizedBox(height: 30),
            Container(
              child: _showSearchResult,
            ),
          ],
        ),
      ),
    );
  }
}
