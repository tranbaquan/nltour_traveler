import 'dart:convert';

import 'package:http/http.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/network/place_url.dart';

class PlaceController {
  Future<List<Place>> getAll() async {
    final client = Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client.get(PlaceUrl.crud, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => Place.fromJson(json.decode(json.encode(m)))).toList();
      }
    });
  }

  Future<List<Place>> findByName(String name) async {
    final client = Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client.get(PlaceUrl.crud + name, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => Place.fromJson(json.decode(json.encode(m)))).toList();
      }
    });
  }
}