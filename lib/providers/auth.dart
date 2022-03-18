import 'dart:io';
import 'package:alen/models/Users.dart';
import 'package:path/path.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  firebase_storage.UploadTask uploadTask;
  double progress=0.0;

  Future<String> uploadImage(File back, String path) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    String fileName = basename(back.path);
    firebase_storage.Reference storageReference =
    storage.ref().child("$path/$fileName");

    uploadTask = storageReference.putFile(back);

    uploadTask.snapshotEvents.listen((event) {
      progress =
          event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      notifyListeners();
      print('EVENT ${progress}');
    });
    firebase_storage.TaskSnapshot snapshot = await uploadTask;
    var imageUrl = await snapshot.ref.getDownloadURL();
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('image', imageUrl);
    return imageUrl;
  }

  Future<Users> fetchUser(String id) async {
    print("ididididididididi $id");
    try {
      var docs =
      await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final Users user = Users(
            id: docs.id,
            firstName: data['first_name'],
            lastName: data['last_name'],
            middleName: data['middle_name'],
            phone: data['phone'],
            image: data['image'],
            age: data['age'],
            location: data['location'],
            email: data['email'],
            sex: data['sex']);
        return user;
      } else {
        return null;
      }
    } catch (error) {
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<dynamic> uploadFile(File file) async {
    String id = await UserPreferences().getId()??"";
    print('token : $id');
    try {
      var license;
      if (file != null) {
        await AuthProvider().uploadImage(file, "userImages").then((res) {
          print('imageuriimageuriimageuri$res');
          if (res != null) {
            license = res;
          }
        });
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'image': license});
      return file;
    } on Exception catch (exception) {
      print("Failed to upload! : $exception");
      return null;
    }
  }

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
      if (userData != null) {

        var prefs = await SharedPreferences.getInstance();
        prefs.setString('user_id', userId);
        prefs.setString('phone', userData['phone']??"");
        prefs.setString('first_name', userData['first_name']??"");
        prefs.setString('middle_name', userData['middle_name']??"");
        prefs.setString('last_name', userData['last_name']??"");
        prefs.setString('email', userData['email']??"");
        prefs.setString('image', userData['image']??"");
        prefs.setString('age', userData['age']??"");
        return true;
      }
      return false;
    } catch (error) {
      hasError = true;
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
      prefs.setString('middle_name', user['middleName']);
      prefs.setString('last_name', user['lastName']);
      prefs.setString('email', user['email']);
      prefs.setString('age', user['age']);

      notifyListeners();
    } catch (e) {
      hasError = true;
      notifyListeners();
    }
    return {'success': !hasError};
  }

  Future updateUser(Users user) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update({
        'first_name': user.firstName,
        'middle_name': user.middleName,
        'last_name': user.lastName,
        'sex': user.sex,
        'email': user.email,
        'age': user.age,
        'location': user.location,
      })
          .then((value) => print("Detail Updated"))
          .catchError((error) =>
          print("Failed to update user: $error"));




      hasError = false;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('first_name', user.firstName);
      prefs.setString('middle_name', user.middleName);
      prefs.setString('last_name', user.lastName);
      prefs.setString('email', user.email);
      prefs.setString('age', user.age);

      notifyListeners();
    } catch (e) {
      hasError = true;
      notifyListeners();
    }
    return {'success': !hasError};
  }
}
