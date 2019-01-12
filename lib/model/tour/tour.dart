import 'package:nltour_traveler/model/collaborator/collaborator.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package:nltour_traveler/model/tour/tour.g.dart';

@JsonSerializable()
class Tour {
  String id;
  Place place;
  Traveler traveler;
  Collaborator tourGuide;
  DateTime startDate;
  double price;
  bool isAccepted;
  bool paid;
  String description;

  Tour({
    this.id,
    this.place,
    this.traveler,
    this.tourGuide,
    this.startDate,
    this.price,
    this.isAccepted,
    this.paid,
    this.description,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
