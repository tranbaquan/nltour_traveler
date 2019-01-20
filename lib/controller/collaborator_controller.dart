import 'dart:convert';

import 'package:http/http.dart';
import 'package:nltour_traveler/model/collaborator/collaborator.dart';
import 'package:nltour_traveler/network/collaborator_url.dart';

class CollaboratorController {
  final client = Client();

  Future<Collaborator> findByEmail(String email) async {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(CollaboratorUrl.crud, headers: headers)
        .then((response) {
      if (response.statusCode < 200 || response.statusCode >= 400) {
        return null;
      } else {
        return Collaborator.fromJson(json.decode(response.body));
      }
    });
  }
}