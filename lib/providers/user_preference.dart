import 'package:alen/ui/Forms/LoginForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences with ChangeNotifier{
  Future<dynamic> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      notifyListeners();
      return token;
    } catch (e) {}
  }
  Future<String> getRole() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('role');
      notifyListeners();
      return token;
    } catch (e) {}
  }
  Future<String> getId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('id');
      notifyListeners();
      return id;
    } catch (e) {}
  }
  Future<dynamic> setRole(Roles role) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('role', role.index.toString());
      print('Set user role : ${prefs.getString('role')}');
      return ;
    } catch (e) {}
  }
  Future<dynamic> setUser(String token, String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      print('Set user token : ${prefs.getString('token')}');
      prefs.setString('id', id);
      print('Set user id : ${prefs.getString('id')}');
      notifyListeners();
      return ;
    } catch (e) {}
  }
  Future<dynamic> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('id');
      prefs.remove('role');
      notifyListeners();
      return;
    } catch (e) {}
  }

}
