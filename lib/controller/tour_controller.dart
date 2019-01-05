import 'package:nltour_traveler/model/tour.dart';
import 'package:http/http.dart' as http;
import 'package:nltour_traveler/network/host.dart';
import 'dart:convert';

class TourController {
  Future<List<Tour>> getAll() async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client.get(Hosting.getAll, headers: headers).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list.map((m) => Tour.fromJson(json.decode(json.encode(m)))).toList();
      }
    });

  }
}
