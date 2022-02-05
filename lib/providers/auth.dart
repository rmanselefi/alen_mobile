import 'package:alen/providers/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  bool hasError;

  //Sign in with Phone Number
  Future<Map<String, dynamic>> signInWithPhone(
      String verId, String smsCode) async {
    var userr;
    String errorMessage;
    AuthCredential _authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    try {
      print("verificationId $verId");
      print("smsCode $smsCode");

      var user =
          await FirebaseAuth.instance.signInWithCredential(_authCredential);
      if (user != null) {
        var token = await user.user.getIdToken();
        var userid = user.user.uid;
        var phone = user.user.phoneNumber;
        userr = {'userid': userid, 'phone': phone};
        if (token != null) {
          hasError = false;
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('token', token);
            notifyListeners();
          });
        }
      }
    } catch (error) {
      hasError = true;
      print(error.message);
    }
    return {'success': !hasError, 'message': errorMessage, 'user': userr};
  }

  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    UserPreferences().signOut();
  }

  Future<bool> checkUserExistence(
      String userId) async {
    try {
      var user =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
      var userData = user.data();
      print("0000000000000000000000");
      print(userId);
      print(userId);
      print(userId);
      print(userData);
      print(userData);
      print("0000000000000000000000");
      if (user != null) {

        var prefs = await SharedPreferences.getInstance();
        prefs.setString('user_id', userId);
        prefs.setString('phone', userData['phone']);
        prefs.setString('first_name', userData['firstName']);
        prefs.setString('middleName', userData['middleName']);
        prefs.setString('lastName', userData['lastName']);
        prefs.setString('email', userData['email']);
        prefs.setString('age', userData['age']);
        return true;
      }
      return false;
    } catch (error) {
      hasError = true;
      print(error.message);
      return false;
    }
  }

  Future signUp(Map<String, dynamic> user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user['userid'])
          .set({
        'phone': user['phone'],
        'first_name': user['firstName'],
        'middle_name': user['middleName'],
        'last_name': user['lastName'],
        'sex': user['sex'],
        'email': user['email'],
        'age': user['age'],
        'location': user['location'],
        'role':'user',
        'created_at': new DateTime.now()
      });
      hasError = false;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', user['userid']);
      prefs.setString('phone', user['phone']);
      prefs.setString('first_name', user['firstName']);
      prefs.setString('middleName', user['middleName']);
      prefs.setString('lastName', user['lastName']);
      prefs.setString('email', user['email']);
      prefs.setString('age', user['age']);

      notifyListeners();
    } catch (e) {
      hasError = true;
      notifyListeners();
    }
    return {'success': !hasError};
  }
}
