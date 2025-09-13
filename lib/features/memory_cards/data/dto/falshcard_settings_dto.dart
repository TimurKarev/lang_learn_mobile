import 'package:json_annotation/json_annotation.dart';

part 'falshcard_settings_dto.g.dart';

@JsonSerializable()
class FalshcardSettingsDto {
  FalshcardSettingsDto({
    required this.isShufle,
    required this.isRepeatWrongCard,
    required this.askLanguage,
  });

  factory FalshcardSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$FalshcardSettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FalshcardSettingsDtoToJson(this);

  @JsonKey(name: 'is_shuffle')
  final bool isShufle;
  @JsonKey(name: 'is_repeat_wrong_card')
  final bool isRepeatWrongCard;
  @JsonKey(name: 'ask_language')
  final String askLanguage;
}
