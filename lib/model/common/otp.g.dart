// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTP _$OTPFromJson(Map<String, dynamic> json) {
  return OTP(
      email: json['email'] as String,
      otp: json['otp'] as String,
      expireTime: json['expireTime'] == null
          ? null
          : DateTime.parse(json['expireTime'] as String),
      identifier: json['identifier'] as String);
}

Map<String, dynamic> _$OTPToJson(OTP instance) => <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'expireTime': instance.expireTime?.toIso8601String(),
      'identifier': instance.identifier
    };
