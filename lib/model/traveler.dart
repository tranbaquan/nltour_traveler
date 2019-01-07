import 'package:nltour_traveler/model/address.dart';
import 'package:nltour_traveler/model/languages.dart';
import 'package:nltour_traveler/model/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'traveler.g.dart';

@JsonSerializable()
class Traveler {
  String firstName;
  String lastName;
  String personalID;
  String email;
  Gender gender;
  String avatar;
  DateTime dob;
  Address address;
  Languages languages;
  String password;
  DateTime activeDate;
  String passport;

  Traveler(
      {this.firstName,
      this.lastName,
      this.personalID,
      this.email,
      this.gender,
      this.avatar,
      this.dob,
      this.address,
      this.languages,
      this.password,
      this.activeDate,
      this.passport});

  factory Traveler.fromJson(Map<String, dynamic> json) =>
      _$TravelerFromJson(json);

  Map<String, dynamic> toJson() => _$TravelerToJson(this);
}
