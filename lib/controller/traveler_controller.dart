import 'package:nltour_traveler/model/otp.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:http/http.dart' as http;
import 'package:nltour_traveler/network/host.dart';
import 'dart:convert';

class TravellerController {
  Future<Traveler> login(Traveler traveler) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.travelerLogin,
            body: json.encode(traveler), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> create(Traveler traveler) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.traveler, body: json.encode(traveler), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> getTraveler(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(Hosting.traveler, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<OTP> getOTP(String email, String requestType) {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'requestType': requestType,
    };
    return client.get(Hosting.getOTP, headers: headers).then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return OTP.fromJson(json.decode(response.body));
      }
    });
  }

  Future<bool> validateOTP(OTP otp) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.getOTP, body: json.encode(otp), headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return false;
      } else {
        return response.body == 'true' ? true : false;
      }
    });
  }

  Future<Traveler> changePassword(
      String email, String newPassword, String identifier) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'newPassword': newPassword,
      'identifier': identifier,
    };

    return await client
        .put(Hosting.changePass, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> findByEmail(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'email': email,
    };

    return await client
        .get(Hosting.traveler, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        print(response.statusCode);
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }
}
