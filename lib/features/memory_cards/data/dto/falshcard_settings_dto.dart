import 'package:json_annotation/json_annotation.dart';

part 'falshcard_settings_dto.g.dart';

@JsonSerializable()
class FalshcardSettingsDto {
  FalshcardSettingsDto({
    required this.shufleCards,
    required this.repeatWrong,
    required this.askLanguage,
  });

  factory FalshcardSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$FalshcardSettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FalshcardSettingsDtoToJson(this);

  final bool shufleCards;
  final bool repeatWrong;
  final String askLanguage;
}
