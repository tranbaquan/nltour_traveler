import 'package:email_validator/email_validator.dart';

class Validator {
  static String validateEmail(String value) {
    if (!EmailValidator.validate(value)) return "Invalid email format!";
    return null;
  }

  static String validatePassword(String value) {
    if(value.length < 6) return "Length must be at least 6 characters!";
  }

  static bool isMatch(String s1, String s2) {
    return s1 == s2;
  }

  static String notEmpty(String value) {
    if(value.isEmpty) return "Not be empty";
    return null;
  }
}