import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_callange_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';

abstract class MemoryChallangePerformer {
  const MemoryChallangePerformer();

  void init(List<MemoryCard> cards);

  MemoryCard? getNextCard({required MemoryChallangeFeedback? feedback});
}
