// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// user profile holder
class Profile {
  // firebase instance
  static final fireStoreInstance = FirebaseFirestore.instance;

  // name and email of user
  static String _name;
  static String _email;

  // sets up user information and returns whether success or not
  static Future<bool> setUserInfo(String userId) async {
    bool downloadData;
    try {
      await fireStoreInstance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        _name = value.data()['name'];
        _email = value.data()['email'];
        downloadData = true;
      });
    } catch (err) {
      downloadData = false;
    }

    return downloadData;
  }

  // get user name
  static String getName() => _name;

  // get user email
  static String getEmail() => _email;
}
