import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<dynamic> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      return token;
    } catch (e) {}
  }
  Future<dynamic> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('user_id');
      prefs.remove('phone');
      prefs.remove('first_name');
      prefs.remove('middleName');
      prefs.remove('lastName');
      prefs.remove('email');
      prefs.remove('age');
      return;
    } catch (e) {}
  }
}
