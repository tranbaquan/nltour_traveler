import 'package:json_annotation/json_annotation.dart';

part 'package:nltour_traveler/model/common/address.g.dart';

@JsonSerializable()
class Address {
  String country;
  String address;

  Address({this.country, this.address});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}