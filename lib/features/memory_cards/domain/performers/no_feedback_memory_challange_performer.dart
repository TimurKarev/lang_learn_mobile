// import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
// import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
// import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

// class NoFeedbackMemoryChallangePerformer implements MemoryChallangePerformer {
//   NoFeedbackMemoryChallangePerformer();

//   List<MemoryCard>? _shuffledCards;
//   int _currentIndex = 0;

//   @override
//   List<FlashcardFeedback?> get history => [];

//   @override
//   void init(List<MemoryCard> cards) {
//     _shuffledCards = List<MemoryCard>.from(cards)..shuffle();
//     _currentIndex = 0;
//   }

//   @override
//   MemoryCard? getNextCard({bool? feedback}) {
//     if (_currentIndex >= _shuffledCards!.length) {
//       return null;
//     }

//     final card = _shuffledCards?[_currentIndex];
//     _currentIndex++;
//     return card;
//   }
// }
