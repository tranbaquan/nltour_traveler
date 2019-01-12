// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      country: json['country'] as String, address: json['address'] as String);
}

Map<String, dynamic> _$AddressToJson(Address instance) =>
    <String, dynamic>{'country': instance.country, 'address': instance.address};
