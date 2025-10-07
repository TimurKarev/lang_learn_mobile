import 'dart:convert';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';

class FlashcardsSettingsCodec extends Codec<FlashcardsSettings?, String> {
  const FlashcardsSettingsCodec();

  @override
  Converter<FlashcardsSettings?, String> get encoder =>
      const _FlashcardsSettingsEncoder();

  @override
  Converter<String, FlashcardsSettings?> get decoder =>
      const _FlashcardsSettingsDecoder();
}

class _FlashcardsSettingsEncoder
    extends Converter<FlashcardsSettings?, String> {
  const _FlashcardsSettingsEncoder();

  @override
  String convert(FlashcardsSettings? input) {
    if (input == null) return '';

    return jsonEncode({
      'isShufleCards': input.isShufleCards,
      'isRepeatWrong': input.isRepeatWrong,
      'askLanguage': input.askLanguage.name,
    });
  }
}

class _FlashcardsSettingsDecoder
    extends Converter<String, FlashcardsSettings?> {
  const _FlashcardsSettingsDecoder();

  @override
  FlashcardsSettings? convert(String input) {
    if (input.isEmpty) return null;

    try {
      final map = jsonDecode(input) as Map<String, dynamic>;
      return FlashcardsSettings(
        isShufleCards: map['isShufleCards'] as bool,
        isRepeatWrong: map['isRepeatWrong'] as bool,
        askLanguage: Languages.getByName(map['askLanguage'] as String),
      );
    } catch (e) {
      return null;
    }
  }
}
