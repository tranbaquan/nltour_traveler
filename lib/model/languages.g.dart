// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Languages _$LanguagesFromJson(Map<String, dynamic> json) {
  return Languages(
      primaryLanguage: json['primaryLanguage'] as String,
      otherLanguages: json['otherLanguages']);
}

Map<String, dynamic> _$LanguagesToJson(Languages instance) => <String, dynamic>{
      'primaryLanguage': instance.primaryLanguage,
      'otherLanguages': instance.otherLanguages
    };
