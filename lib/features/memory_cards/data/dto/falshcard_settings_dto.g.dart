// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'falshcard_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FalshcardSettingsDto _$FalshcardSettingsDtoFromJson(
  Map<String, dynamic> json,
) => FalshcardSettingsDto(
  shufleCards: json['shufleCards'] as bool,
  repeatWrong: json['repeatWrong'] as bool,
  askLanguage: json['askLanguage'] as String,
);

Map<String, dynamic> _$FalshcardSettingsDtoToJson(
  FalshcardSettingsDto instance,
) => <String, dynamic>{
  'shufleCards': instance.shufleCards,
  'repeatWrong': instance.repeatWrong,
  'askLanguage': instance.askLanguage,
};
