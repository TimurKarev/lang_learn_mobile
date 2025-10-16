import 'dart:convert';
import 'package:lang_learn_mobile/core/router/codecs/challenge_theme_codec.dart';
import 'package:lang_learn_mobile/core/router/codecs/flashcards_settings_codec.dart';
import 'package:lang_learn_mobile/core/router/codecs/flashcard_feedback_codec.dart';
import 'package:lang_learn_mobile/core/router/codecs/ui_error_codec.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';

class CombinedCodec extends Codec<Object?, String> {
  const CombinedCodec();

  @override
  Converter<Object?, String> get encoder => const _CombinedEncoder();

  @override
  Converter<String, Object?> get decoder => const _CombinedDecoder();
}

class _CombinedEncoder extends Converter<Object?, String> {
  const _CombinedEncoder();

  @override
  String convert(Object? input) {
    if (input == null) return '';

    if (input is ChallengeThemes) {
      return 'challenge_theme:${const ChallengeThemesCodec().encoder.convert(input)}';
    } else if (input is FlashcardsSettings) {
      return 'flashcards_settings:${const FlashcardsSettingsCodec().encoder.convert(input)}';
    } else if (input is List<FlashcardFeedback?>) {
      final encodedList = input
          .map((item) => const FlashcardFeedbackCodec().encoder.convert(item))
          .join('|');
      return 'flashcard_feedback_list:$encodedList';
    } else if (input is UiError) {
      return 'ui_error:${const UiErrorCodec().encoder.convert(input)}';
    }

    throw ArgumentError('Unsupported type for encoding: ${input.runtimeType}');
  }
}

class _CombinedDecoder extends Converter<String, Object?> {
  const _CombinedDecoder();

  @override
  Object? convert(String input) {
    if (input.isEmpty) return null;

    if (input.startsWith('challenge_theme:')) {
      final data = input.substring('challenge_theme:'.length);
      return const ChallengeThemesCodec().decoder.convert(data);
    } else if (input.startsWith('flashcards_settings:')) {
      final data = input.substring('flashcards_settings:'.length);
      return const FlashcardsSettingsCodec().decoder.convert(data);
    } else if (input.startsWith('flashcard_feedback_list:')) {
      final data = input.substring('flashcard_feedback_list:'.length);
      if (data.isEmpty) return <FlashcardFeedback?>[];

      final items = data.split('|');
      return items
          .map((item) => const FlashcardFeedbackCodec().decoder.convert(item))
          .toList();
    } else if (input.startsWith('ui_error:')) {
      final data = input.substring('ui_error:'.length);
      return const UiErrorCodec().decoder.convert(data);
    }

    // Try to decode as challenge theme for backward compatibility
    try {
      return const ChallengeThemesCodec().decoder.convert(input);
    } catch (e) {
      // If that fails, try flashcards settings
      try {
        return const FlashcardsSettingsCodec().decoder.convert(input);
      } catch (e2) {
        throw ArgumentError('Unsupported format for decoding: $input');
      }
    }
  }
}
