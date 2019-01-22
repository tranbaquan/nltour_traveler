import 'dart:convert';

import 'package:http/http.dart';
import 'package:nltour_traveler/controller/common.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/network/traveler_url.dart';

class TravellerController {
  final client = Client();

  Future<Traveler> login(Traveler traveler) async {
    return await client
        .post(TravelerUrl.login,
            body: json.encode(traveler), headers: DefaultForm.defaultHeaders)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> create(Traveler traveler) async {
    return await client
        .post(TravelerUrl.crud, body: json.encode(traveler), headers: DefaultForm.defaultHeaders)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> update(Traveler traveler) async {
    return await client
        .put(TravelerUrl.crud, body: json.encode(traveler), headers: DefaultForm.defaultHeaders)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> getTraveler(String email) async {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(TravelerUrl.crud, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> changePasswordByOtp(
      String email, String newPassword, String identifier) async {
    final client = Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'newPassword': newPassword,
      'identifier': identifier,
    };

    return await client
        .put(TravelerUrl.otp, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> changePassword(
      String email,String oldPassword, String newPassword) async {
    final client = Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
      'oldPassword': oldPassword,
      'newPassword': newPassword,

    };

    return await client
        .put(TravelerUrl.password, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }

  Future<Traveler> findByEmail(String email) async {
    final client = Client();
    final headers = {
      'Content-type': 'application/json',
      'email': email,
    };

    return await client
        .get(TravelerUrl.crud, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Traveler.fromJson(json.decode(response.body));
      }
    });
  }
}
