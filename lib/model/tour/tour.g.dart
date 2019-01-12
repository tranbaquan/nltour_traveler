// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) {
  return Tour(
      id: json['id'] as String,
      place: json['place'] == null
          ? null
          : Place.fromJson(json['place'] as Map<String, dynamic>),
      traveler: json['traveler'] == null
          ? null
          : Traveler.fromJson(json['traveler'] as Map<String, dynamic>),
      tourGuide: json['tourGuide'] == null
          ? null
          : Collaborator.fromJson(json['tourGuide'] as Map<String, dynamic>),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      price: (json['price'] as num)?.toDouble(),
      isAccepted: json['isAccepted'] as bool,
      paid: json['paid'] as bool,
      description: json['description'] as String);
}

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'id': instance.id,
      'place': instance.place,
      'traveler': instance.traveler,
      'tourGuide': instance.tourGuide,
      'startDate': instance.startDate?.toIso8601String(),
      'price': instance.price,
      'isAccepted': instance.isAccepted,
      'paid': instance.paid,
      'description': instance.description
    };
