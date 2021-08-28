import 'package:alen/models/hospital.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Pages/Hospital.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
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
  LoggedOut,
  InvalidCredential,
  NonWithThisAccount
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

  Future <Status> signInHospital(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      String userToken= await auth.currentUser.getIdToken();
      String userId = auth.currentUser.uid;
        var docs = await FirebaseFirestore.instance.collection('hospital').get();
        if (docs.docs.isNotEmpty) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            String hospitalId= data['id'];
            if(data['user_id']==userId){
              UserPreferences().setUser(userToken, hospitalId);
              return Status.LoggedIn;
            }
          }
        }
        return Status.NonWithThisAccount;
    } on FirebaseAuthException catch (e) {
      print("----------------Nooooooooooooo-------------");
      print("----------------${e.message}-------------");
      print("----------------Nooooooooooooo-------------");
      return Status.InvalidCredential;
    }
  }
  Future <Status> signInLaboratorist(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      String userToken= await auth.currentUser.getIdToken();
      String userId = auth.currentUser.uid;
        var docs = await FirebaseFirestore.instance.collection('laboratory').get();
        if (docs.docs.isNotEmpty) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            String hospitalId= data['id'];
            if(data['user_id']==userId){
              UserPreferences().setUser(userToken, hospitalId);
              return Status.LoggedIn;
            }
          }
        }
        return Status.NonWithThisAccount;
    } on FirebaseAuthException catch (e) {
      print("----------------Nooooooooooooo-------------");
      print("----------------${e.message}-------------");
      print("----------------Nooooooooooooo-------------");
      return Status.InvalidCredential;
    }
  }
  Future <Status> signInDiagnostics(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      String userToken= await auth.currentUser.getIdToken();
      String userId = auth.currentUser.uid;
        var docs = await FirebaseFirestore.instance.collection('diagnostics').get();
        if (docs.docs.isNotEmpty) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            String hospitalId= data['id'];
            if(data['user_id']==userId){
              UserPreferences().setUser(userToken, hospitalId);
              return Status.LoggedIn;
            }
          }
        }
        return Status.NonWithThisAccount;
    } on FirebaseAuthException catch (e) {
      print("----------------Nooooooooooooo-------------");
      print("----------------${e.message}-------------");
      print("----------------Nooooooooooooo-------------");
      return Status.InvalidCredential;
    }
  }
  Future <Status> signInPharmacy(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      String userToken= await auth.currentUser.getIdToken();
      String userId = auth.currentUser.uid;
      print("object${auth}");
      var docs = await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if(docs.exists) {
        var data = docs.data();


          String role= data['role'];
          // print(hospitalId);
          // if(data['user_id']==userId){
          //   UserPreferences().setUser(userToken, hospitalId);
          //   return Status.LoggedIn;
          // }

      }
      return Status.NonWithThisAccount;
    } on FirebaseAuthException catch (e) {
      print("----------------Nooooooooooooo-------------");
      print("----------------${e.message}-------------");
      print("----------------Nooooooooooooo-------------");
      return Status.InvalidCredential;
    }
  }
  Future <Status> signInImporter(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      String userToken= await auth.currentUser.getIdToken();
      String userId = auth.currentUser.uid;
      var docs = await FirebaseFirestore.instance.collection('importers').get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          String hospitalId= data['id'];
          print(hospitalId);
          if(data['user_id']==userId){
            UserPreferences().setUser(userToken, hospitalId);
            return Status.LoggedIn;
          }
        }
      }
      return Status.NonWithThisAccount;
    } on FirebaseAuthException catch (e) {
      print("----------------Nooooooooooooo-------------");
      print("----------------${e.message}-------------");
      print("----------------Nooooooooooooo-------------");
      return Status.InvalidCredential;
    }
  }
}
