// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
      type: _$enumDecodeNullable(_$TourGuideTypeEnumMap, json['type']),
      pricePerTour: (json['pricePerTour'] as num)?.toDouble());
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'type': _$TourGuideTypeEnumMap[instance.type],
      'pricePerTour': instance.pricePerTour
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TourGuideTypeEnumMap = <TourGuideType, dynamic>{
  TourGuideType.PROFESSOR: 'PROFESSOR',
  TourGuideType.FREELANCER: 'FREELANCER',
  TourGuideType.STUDENT: 'STUDENT',
  TourGuideType.RESIDENT: 'RESIDENT'
};
