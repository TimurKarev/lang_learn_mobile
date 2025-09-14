import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart'
    show FlashcardFeedback;
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

abstract interface class MemoryChallangePerformer {
  String get challengeId;

  List<FlashcardFeedback?> get history;

  void init({
    required List<Flashcard> cards,
    required FlashcardsSettings settings,
  });

  Flashcard? startChallange();

  Flashcard? restart({required FlashcardsSettings settings});

  Flashcard? getNextCard({bool? feedback});
}
