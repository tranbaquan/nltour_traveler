import 'dart:convert';

import 'package:http/http.dart';
import 'package:nltour_traveler/controller/common.dart';
import 'package:nltour_traveler/model/common/otp.dart';
import 'package:nltour_traveler/network/traveler_url.dart';

class OTPController {
  final client = Client();
  Future<OTP> getOTP(String email, String requestType) {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'requestType': requestType,
    };
    return client.get(TravelerUrl.otp, headers: headers).then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return OTP.fromJson(json.decode(response.body));
      }
    });
  }

  Future<bool> validateOTP(OTP otp) async {
    return await client
        .post(TravelerUrl.otp, body: json.encode(otp), headers: DefaultForm.defaultHeaders)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return false;
      } else {
        return response.body == 'true' ? true : false;
      }
    });
  }
}