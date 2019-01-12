import 'package:json_annotation/json_annotation.dart';
import 'package:nltour_traveler/model/collaborator/type.dart';
import 'package:nltour_traveler/model/common/address.dart';
import 'package:nltour_traveler/model/common/languages.dart';

part 'package:nltour_traveler/model/collaborator/collaborator.g.dart';

@JsonSerializable()
class Collaborator {
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
  TourGuideType type;
  String phoneNumber;

  Collaborator(
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
      this.type,
      this.phoneNumber});

  factory Collaborator.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorFromJson(json);

  Map<String, dynamic> toJson() => _$CollaboratorToJson(this);
}
