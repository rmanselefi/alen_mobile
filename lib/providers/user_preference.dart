import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<dynamic> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      return token;
    } catch (e) {}
  }
}
