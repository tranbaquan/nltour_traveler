import 'package:email_validator/email_validator.dart';

class Validator {
  static String validateEmail(String value) {
    if (!EmailValidator.validate(value)) return "";
    return null;
  }

  static String validatePassword(String value) {
    if(value.length < 6) return "";
  }
}