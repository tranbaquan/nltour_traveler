import 'package:shared_preferences/shared_preferences.dart';

class SessionChecker {
  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLogged = prefs.getBool('logged');

    if (isLogged != null && isLogged) {
      return true;
    }

    return false;
  }
}

class SessionSupporter {

}