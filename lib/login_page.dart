import 'package:flutter/material.dart';

// third party libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// local
import 'home_page.dart';
// import 'models/profile.dart';

// password recovery form
import 'password_reset_page.dart';

// firebase authenticator
final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  // key used for validating the user's email and password
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // email text box
  final TextEditingController _emailController = TextEditingController();
  // password text box
  final TextEditingController _passwordController = TextEditingController();

  bool _success;  // successful log in
  String _userEmail;  // email of success log in to save
  // String _userId;  // user doc id
  String _errorDesc;  // description of error if unsuccessful log in

  @override
  void initState() {
    super.initState();
    getEmailFromStorage();  // gets email if stored in local storage
  }

  /*
   * Button to push user to forgot password page
   */
  FlatButton _forgotPasswordButton() {
    return FlatButton(
        child: const Text(
          'Forgot password?',
        ),
        onPressed:  () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordRecoveryPage()
            ),
          );
        }
    );
  }

  Widget _emailPasswordForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // text field used for entering the email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              cursorColor: Colors.white,
              validator: (val) {
                if(val.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            // text field used for entering the password
            TextFormField(
              obscureText: true,  // hides the password
              enableSuggestions: false,  // disable suggestions
              autocorrect: false,  // do not allow auto correct
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (val) {
                if(val.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: Text(
                _success == null
                    ? ''
                    : (_success ? '' : _errorDesc),
                style: TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // button for validating
            SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                color: Colors.blueGrey,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()
                    ),
                  );

                  // if(_formKey.currentState.validate()) {
                  //   // check to see if it was a successful login
                  //   _signInWithEmailAndPassword().then((isLoggedIn) {
                  //     // clears password input field
                  //     _passwordController.clear();
                  //     if(isLoggedIn) {
                  //       _saveEmailToStorage();
                  //       AltaUser.setUserInfo(_userId).then((good) {
                  //         if(good) {
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //                 builder: (context) => HomePage()
                  //             ),
                  //           );
                  //         } else {
                  //           TODO: add error message for unsuccessful login
                  //           print("error");
                  //         }
                  //       });
                  //     }
                  //   });
                  // }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  /*
   * Get email stored locally
   */
  void getEmailFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('email');

    if(userEmail != null) {
      setState(() {
        // sets the text of the controller to the user email
        _emailController.text = userEmail;
      });
    }
  }

  /*
   * Save email in local storage
   */
  void _saveEmailToStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _userEmail);
  }

  /*
   * Function used to sign in an user
   * using firebase authentication system
   * TODO: sign in with password in profile class
   */
  Future<bool> _signInWithEmailAndPassword() async {

    // authenticated by Firebase
    User user;
    bool loggedIn = false;

    try {
      // sign in the user using email and password
      user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      )).user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          // _userId = user.uid;
        });
        loggedIn = true;
      }
    } on FirebaseAuthException catch (error) {
      // if password or email don't match
      setState(() {
        _success = false;
        if (error.code == 'user-not-found') {
          _errorDesc = 'No user found for that email.';
        } else if (error.code == 'wrong-password') {
          _errorDesc = 'Wrong password provided for that user.';
        }
      });
      loggedIn = false;
      _saveEmailToStorage();
    }

    return loggedIn;
  }

  // cleans the components when closed
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterLogo(size: 100),
                _emailPasswordForm(),
                _forgotPasswordButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

