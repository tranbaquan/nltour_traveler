import 'package:nltour_traveler/model/collaborator.dart';
import 'package:nltour_traveler/model/place.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {
  String id;
  Place place;
  Traveler traveler;
  Collaborator tourGuide;
  DateTime startDate;
  double price;

  Tour(
      {this.id,
      this.place,
      this.traveler,
      this.tourGuide,
      this.startDate,
      this.price});

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
