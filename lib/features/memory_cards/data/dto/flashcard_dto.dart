import 'package:json_annotation/json_annotation.dart';
import 'package:lang_learn_mobile/core/mappers/dto_mapper.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/litera_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

part 'flashcard_dto.g.dart';

@JsonSerializable(createToJson: false)
class FlashcardDto implements DtoMapper<Flashcard> {
  final String id;
  @JsonKey(name: 'from_translations')
  final LiteralDto fWord;
  @JsonKey(name: 'to_translations')
  final LiteralDto sWord;

  const FlashcardDto({
    required this.id,
    required this.fWord,
    required this.sWord,
  });

  factory FlashcardDto.fromJson(Map<String, dynamic> json) =>
      _$FlashcardDtoFromJson(json);

  @override
  Flashcard toEntity() {
    return Flashcard(id: id, fWord: fWord.toEntity(), sWord: sWord.toEntity());
  }
}
