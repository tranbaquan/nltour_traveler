import 'package:nltour_traveler/model/tour.dart';
import 'package:http/http.dart' as http;
import 'package:nltour_traveler/network/host.dart';
import 'dart:convert';

class TourController {
  Future<List> getAll() async {
    final client = http.Client();
//    final headers = {
//      'Content-type': 'application/json',
//      'Accept': 'application/json',
//    };
    return await client.get(Hosting.getAll).then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        print(false);
        return null;
      } else {
        print(response.body);
        List list = json.decode(response.body) as List;
        print(list);
//        List<Tour> tours = new List();
//        for (dynamic tour in list) {
//          Tour t = Tour.fromJson(json.decode(tour));
//          tours.add(t);
//        }
        return list;
      }
    });

  }
}
