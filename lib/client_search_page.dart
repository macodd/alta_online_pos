import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'client_info_page.dart';

import 'models/cart.dart';
import 'models/customer.dart';

class ClientSearchPage extends StatefulWidget {
  @override
  _ClientSearchPageState createState() => _ClientSearchPageState();
}

class _ClientSearchPageState extends State<ClientSearchPage> {
  // search field editor
  final TextEditingController _searchField = TextEditingController();

  // form key
  final GlobalKey<FormState> _searchFormKey = new GlobalKey();

  // client id used for search
  String _clientID;

  // widget to show if customer is found
  Widget _showSearchResult;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _searchField.dispose();
  }

  /*
   * Validator for text field
   */
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

  void showFoundClient(Customer _customer) {
    if (_customer != null) {
      setState(() {
        _showSearchResult = Column(
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
                Order.setCustomer(_customer);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientInfoPage())
                );
              },
            )
          ],
        );
      });
    } else {
      setState(() {
        _showSearchResult = Column(
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
            ]);
      });
    }
  }

  // widget to re route base on selection
  Widget searchButton() {
    return Container(
      width: 150,
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
          }),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Client ID Search",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
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
                                borderRadius: BorderRadius.circular(30))),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(13)
                        ],
                        onSaved: (val) {
                          _clientID = val;
                        },
                        validator: _clientValidation,
                      ),
                    )),
                searchButton(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: _showSearchResult,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
