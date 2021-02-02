import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// local pages
import 'login_page.dart';
import 'home_page.dart';

/*
 * Main function that starts app
 * waits for firebase to initialize before starting the app
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // waits on firebase to initialize
  runApp(AltaApp());
}

class AltaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alta Online Payment",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonBarTheme: ButtonBarThemeData(
          alignment: MainAxisAlignment.center
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => HomePage(),
      },
    );
  }
}
