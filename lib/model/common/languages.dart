import 'package:json_annotation/json_annotation.dart';

part 'package:nltour_traveler/model/common/languages.g.dart';

@JsonSerializable()
class Languages {
  String primaryLanguage;
  dynamic otherLanguages;

  Languages({this.primaryLanguage, this.otherLanguages});

  factory Languages.fromJson(Map<String, dynamic> json) => _$LanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$LanguagesToJson(this);
}