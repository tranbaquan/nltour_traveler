import 'package:nltour_traveler/model/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  String id;
  String name;
  String imageUrl;
  String description;
  Address address;
  int visitCounter;

  Place({this.id, this.name, this.imageUrl, this.description, this.address, this.visitCounter});

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
