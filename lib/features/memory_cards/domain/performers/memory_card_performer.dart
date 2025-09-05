import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart'
    show FlashcardFeedback;
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';

abstract interface class MemoryChallangePerformer {
  const MemoryChallangePerformer();

  List<FlashcardFeedback?> get history;

  MemoryCard? startChallange();

  void init(List<MemoryCard> cards);

  MemoryCard? getNextCard({bool? feedback});
}
