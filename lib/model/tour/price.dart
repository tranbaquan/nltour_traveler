import 'package:nltour_traveler/model/collaborator/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package:nltour_traveler/model/tour/price.g.dart';

@JsonSerializable()
class Price {
  TourGuideType type;
  double pricePerTour;

  Price({this.type, this.pricePerTour});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}