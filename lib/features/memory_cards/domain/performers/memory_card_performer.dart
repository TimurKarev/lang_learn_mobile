import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart'
    show FlashcardFeedback;
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';

abstract interface class MemoryChallangePerformer {
  const MemoryChallangePerformer();

  List<FlashcardFeedback?> get history;

  MemoryCard? startChallange();

  void init({
    required List<MemoryCard> cards,
    required FlashcardsSettings settings,
  });

  MemoryCard? getNextCard({bool? feedback});
}
