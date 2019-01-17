import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/supporter/database/database.dart';
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
  static Future<Traveler> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    return DatabaseProvider.db.getTraveler(email);
  }
}