import 'package:http/http.dart' as http;
import 'package:nltour_traveler/model/place.dart';
import 'package:nltour_traveler/network/host.dart';
import 'dart:convert';

class PlaceController {
  Future<List<Place>> getAll() async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client.get(Hosting.getAllPlaces, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => Place.fromJson(json.decode(json.encode(m)))).toList();
      }
    });
  }

  Future<List<Place>> findByName(String name) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client.get(Hosting.getAllPlaces, headers: headers).then((response) {
//    return await client.get(Hosting.getPlacesByName + name, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => Place.fromJson(json.decode(json.encode(m)))).toList();
      }
    });
  }
}