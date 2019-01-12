// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(json['email'] as String, json['message'] as String);
}

Map<String, dynamic> _$MessageToJson(Message instance) =>
    <String, dynamic>{'email': instance.email, 'message': instance.message};
