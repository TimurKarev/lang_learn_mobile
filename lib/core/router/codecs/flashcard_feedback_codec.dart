import 'dart:convert';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';

class FlashcardFeedbackCodec extends Codec<FlashcardFeedback?, String> {
  const FlashcardFeedbackCodec();

  @override
  Converter<FlashcardFeedback?, String> get encoder =>
      const _FlashcardFeedbackEncoder();

  @override
  Converter<String, FlashcardFeedback?> get decoder =>
      const _FlashcardFeedbackDecoder();
}

class _FlashcardFeedbackEncoder extends Converter<FlashcardFeedback?, String> {
  const _FlashcardFeedbackEncoder();

  @override
  String convert(FlashcardFeedback? input) {
    if (input == null) return '';

    return jsonEncode({
      'isCorrect': input.isCorrect,
      'card': {
        'id': input.card.id,
        'fWord': {
          'id': input.card.fWord.id,
          'word': input.card.fWord.word,
          'transcript': input.card.fWord.transcript,
          'lang': input.card.fWord.lang.name,
        },
        'sWord': {
          'id': input.card.sWord.id,
          'word': input.card.sWord.word,
          'transcript': input.card.sWord.transcript,
          'lang': input.card.sWord.lang.name,
        },
      },
    });
  }
}

class _FlashcardFeedbackDecoder extends Converter<String, FlashcardFeedback?> {
  const _FlashcardFeedbackDecoder();

  @override
  FlashcardFeedback? convert(String input) {
    if (input.isEmpty) return null;

    try {
      final map = jsonDecode(input) as Map<String, dynamic>;
      final cardMap = map['card'] as Map<String, dynamic>;
      final fWordMap = cardMap['fWord'] as Map<String, dynamic>;
      final sWordMap = cardMap['sWord'] as Map<String, dynamic>;

      return FlashcardFeedback(
        isCorrect: map['isCorrect'] as bool?,
        card: Flashcard(
          id: cardMap['id'] as String,
          fWord: Literal(
            id: fWordMap['id'] as String,
            word: fWordMap['word'] as String,
            transcript: fWordMap['transcript'] as String,
            lang: Languages.getByName(fWordMap['lang'] as String),
            hasAudio: fWordMap['hasAudio'] as bool,
            stringHint: fWordMap['stringHint'] as String,
            imagePath: sWordMap['imagePath'] as String,
          ),
          sWord: Literal(
            id: sWordMap['id'] as String,
            word: sWordMap['word'] as String,
            transcript: sWordMap['transcript'] as String,
            lang: Languages.getByName(sWordMap['lang'] as String),
            hasAudio: sWordMap['hasAudio'] as bool,
            stringHint: sWordMap['stringHint'] as String,
            imagePath: sWordMap['imagePath'] as String,
          ),
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
