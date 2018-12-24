import 'package:nltour_traveler/model/traveler.dart';
import 'package:http/http.dart' as http;
import 'package:nltour_traveler/network/host.dart';
import 'dart:convert';

class LoginPageController {
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
}
