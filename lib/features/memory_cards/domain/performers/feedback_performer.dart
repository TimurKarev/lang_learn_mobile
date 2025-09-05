import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

class FeedbackPerformer implements MemoryChallangePerformer {
  FeedbackPerformer() : history = [];

  @override
  final List<FlashcardFeedback?> history;
  List<MemoryCard>? _shuffledCards;
  int _currentIndex = 0;

  @override
  void init(List<MemoryCard> cards) {
    _shuffledCards = List<MemoryCard>.from(cards)..shuffle();
    _currentIndex = 0;
  }

  @override
  MemoryCard? startChallange() {
    _currentIndex = 0;
    final cards = _shuffledCards;
    if (cards == null) {
      return null;
    }

    if (_currentIndex >= cards.length) {
      return null;
    }
    return cards[_currentIndex];
  }

  @override
  MemoryCard? getNextCard({bool? feedback}) {
    final cards = _shuffledCards;
    if (cards == null) {
      return null;
    }

    if (_currentIndex >= cards.length) {
      return null;
    }

    final currentCard = cards[_currentIndex];
    history.add(FlashcardFeedback(isCorrect: feedback, card: currentCard));

    _currentIndex++;

    if (_currentIndex >= cards.length) {
      return null;
    }

    return cards[_currentIndex];
  }
}
