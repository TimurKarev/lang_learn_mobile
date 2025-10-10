import 'package:lang_learn_mobile/core/mappers/dto_mapper.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/litera_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

class FlashcardDto implements DtoMapper<Flashcard> {
  final String id;
  final LiteralDto fWord;
  final LiteralDto sWord;

  const FlashcardDto({
    required this.id,
    required this.fWord,
    required this.sWord,
  });

  factory FlashcardDto.fromJson(Map<String, dynamic> json) => FlashcardDto(
    id: json['id'] as String,
    fWord: LiteralDto(
      id: '',
      word: json['from_word'] as String,
      transcript: json['from_transcript'] as String? ?? '',
      lang: json['from_translation_lang'] as String,
    ),
    sWord: LiteralDto(
      id: '',
      word: json['to_word'] as String,
      transcript: json['to_transcript'] as String? ?? '',
      lang: json['to_translation_lang'] as String,
    ),
  );

  @override
  Flashcard toEntity() {
    return Flashcard(id: id, fWord: fWord.toEntity(), sWord: sWord.toEntity());
  }
}
