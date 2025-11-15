import 'package:lang_learn_mobile/core/mappers/dto_mapper.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'memory_cards_preview_dto.g.dart';

@JsonSerializable(createToJson: false)
class MemoryCardsPreviewDto implements DtoMapper<MemoryCardsPreview> {
  MemoryCardsPreviewDto({
    required this.id,
    required this.title,
    required this.description,
    required this.themeName,
  });

  final String? id;
  final String? title;
  final String? description;
  @JsonKey(name: 'theme_name')
  final String? themeName;

  factory MemoryCardsPreviewDto.fromJson(Map<String, dynamic> json) =>
      _$MemoryCardsPreviewDtoFromJson(json);

  // TODO: make empty value and return it in some cases
  @override
  MemoryCardsPreview toEntity() {
    return MemoryCardsPreview(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      theme: ChallengeThemes.getByName(themeName),
    );
  }
}
