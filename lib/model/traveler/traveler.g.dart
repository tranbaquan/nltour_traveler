// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traveler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Traveler _$TravelerFromJson(Map<String, dynamic> json) {
  return Traveler(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      personalID: json['personalID'] as String,
      email: json['email'] as String,
      gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
      avatar: json['avatar'] as String,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      languages: json['languages'] == null
          ? null
          : Languages.fromJson(json['languages'] as Map<String, dynamic>),
      password: json['password'] as String,
      activeDate: json['activeDate'] == null
          ? null
          : DateTime.parse(json['activeDate'] as String),
      passport: json['passport'] as String);
}

Map<String, dynamic> _$TravelerToJson(Traveler instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'personalID': instance.personalID,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
      'dob': instance.dob?.toIso8601String(),
      'address': instance.address,
      'languages': instance.languages,
      'password': instance.password,
      'activeDate': instance.activeDate?.toIso8601String(),
      'passport': instance.passport
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

const _$GenderEnumMap = <Gender, dynamic>{
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE'
};
