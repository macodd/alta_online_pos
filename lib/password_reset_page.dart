import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

/*
  Password recovery page that shows the user
  an input field for their email in order to reset
  their password.
 */
class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  // key used for validating the user's email and password
  final GlobalKey<FormState> _recoveryFormKey = GlobalKey<FormState>();
  // email text box
  final TextEditingController _emailController = TextEditingController();

  // message shown to user about email recovery
  Widget passwordRecoveryMessage() {
    return Text(
      'Password Reset',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  // form used for submitting an email for password recovery
  Widget emailRecoveryForm() {
    return Form(
      key: _recoveryFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // text field used for entering the email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String val) {
              if (val.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Builder(builder: (BuildContext context) {
              return SizedBox(
                height: 50,
                width: 200,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () async {
                    if (_recoveryFormKey.currentState.validate()) {
                      // send email via firebase
                      resetPassword(_emailController.text);
                      // inform user of email reset
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Email sent.'),
                      )
                      );
                    }
                  },
                  child: const Text(
                    'Recover',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              );
            })
          ),
        ]
      ),
    );
  }

  // reset password using firebase
  void resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: [
            passwordRecoveryMessage(),
            SizedBox(height: 30),
            emailRecoveryForm(),
          ],
        ),
      )
    );
  }
}
