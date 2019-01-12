import 'package:nltour_traveler/model/collaborator/collaborator.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
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
    return await client
        .get(Hosting.getAllTours, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future<List<Collaborator>> getRegisteringTours(String tourId) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'tourId': tourId,
    };
    return await client
        .get(Hosting.getRegisteredTours, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Collaborator.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future<Tour> createTour(Tour tour) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return await client
        .post(Hosting.tour, headers: headers, body: json.encode(tour))
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        return Tour.fromJson(json.decode(response.body));
      }
    });
  }

  Future<List<Tour>> getMyTour(String email) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'email': email,
    };
    return await client
        .get(Hosting.getMyTours, headers: headers)
        .then((response) {
      if (response.statusCode < 200 && response.statusCode >= 400) {
        return null;
      } else {
        List list = json.decode(response.body) as List;
        return list
            .map((m) => Tour.fromJson(json.decode(json.encode(m))))
            .toList();
      }
    });
  }

  Future cancelTour(String id) async {
    final client = http.Client();
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'id': id,
    };

    return await client.delete(Hosting.tour, headers: headers);
  }
}
