// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'falshcard_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FalshcardSettingsDto _$FalshcardSettingsDtoFromJson(
  Map<String, dynamic> json,
) => FalshcardSettingsDto(
  isShufle: json['is_shuffle'] as bool,
  isRepeatWrongCard: json['is_repeat_wrong_card'] as bool,
  askLanguage: json['ask_language'] as String,
  isShowHint: json['is_show_hint'] as bool,
);

Map<String, dynamic> _$FalshcardSettingsDtoToJson(
  FalshcardSettingsDto instance,
) => <String, dynamic>{
  'is_shuffle': instance.isShufle,
  'is_repeat_wrong_card': instance.isRepeatWrongCard,
  'ask_language': instance.askLanguage,
  'is_show_hint': instance.isShowHint,
};
