import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static Future<String?> getUserIdFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<bool> setUserIdToSP(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', userId);
  }

  static Future<bool> removeUserIdFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('userId');
  }
}
