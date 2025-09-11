import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';

abstract interface class FlashcardSettingsRepository {
  Future<Either<Failure, void>> saveSettings(FlashcardsSettings settings);
  Future<Either<Failure, FlashcardsSettings>> getSettings({
    required FlashcardsSettings defaultSettings,
  });
}
