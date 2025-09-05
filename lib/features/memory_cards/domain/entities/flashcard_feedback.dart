import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';

class FlashcardFeedback {
  const FlashcardFeedback({this.isCorrect, required this.card});

  final bool? isCorrect;
  final MemoryCard card;
}
