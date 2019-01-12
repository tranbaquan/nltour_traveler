import 'package:nltour_traveler/network/host.dart';

class TravelerUrl {
  static final String traveler = Hosting.host + "traveler";
  static final String login = traveler + "/login";
  static final String info = traveler + "/info";
}