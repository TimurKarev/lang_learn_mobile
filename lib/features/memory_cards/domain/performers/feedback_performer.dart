import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

class FeedbackPerformer implements MemoryChallangePerformer {
  FeedbackPerformer() : history = [];

  @override
  final List<FlashcardFeedback?> history;
  List<MemoryCard>? _shuffledCards;
  FlashcardsSettings _settings = FlashcardsSettings.initial();
  int _currentIndex = 0;

  @override
  void init({
    required List<MemoryCard> cards,
    required FlashcardsSettings settings,
  }) {
    _settings = settings;
    _shuffledCards = List<MemoryCard>.from(cards);
    if (_settings.shufleCards) {
      _shuffledCards?.shuffle();
    }
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
    return _settings.askLanguage == Languages.russian
        ? cards[_currentIndex].revert()
        : cards[_currentIndex];
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

    final nextCard = _settings.askLanguage == Languages.russian
        ? cards[_currentIndex].revert()
        : cards[_currentIndex];

    if (_settings.repeatWrong && feedback == false) {
      _shuffledCards?.add(currentCard);
    }

    return nextCard;
  }
}
