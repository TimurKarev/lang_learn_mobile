import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

class FeedbackPerformer implements MemoryChallangePerformer {
  FeedbackPerformer({required this.challengeTheme}) : history = [];

  @override
  final ChallengeThemes challengeTheme;

  @override
  final List<FlashcardFeedback?> history;
  List<Flashcard>? _initialCards;
  List<Flashcard>? _shuffledCards;
  FlashcardsSettings _settings = FlashcardsSettings.initial();
  int _currentIndex = 0;

  @override
  void init({
    required List<Flashcard> cards,
    required FlashcardsSettings settings,
  }) {
    _settings = settings;
    _initialCards = List<Flashcard>.from(cards);
    _shuffledCards = List<Flashcard>.from(cards);
    if (_settings.isShufleCards) {
      _shuffledCards?.shuffle();
    }
    _currentIndex = 0;
  }

  @override
  Flashcard? restart({required FlashcardsSettings settings}) {
    if (_initialCards case final List<Flashcard> cards when cards.isNotEmpty) {
      _settings = settings;
      _shuffledCards = List<Flashcard>.from(cards);
      if (_settings.isShufleCards) {
        _shuffledCards?.shuffle();
      }
      _currentIndex = 0;

      return startChallange();
    }

    return null;
  }

  @override
  Flashcard? startChallange() {
    final cards = _shuffledCards;
    if (cards == null) {
      return null;
    }

    if (_currentIndex >= cards.length) {
      return null;
    }
    return _getCard(cards[_currentIndex]);
  }

  @override
  Flashcard? getNextCard({bool? feedback}) {
    final cards = _shuffledCards;
    if (cards == null) {
      return null;
    }

    if (_currentIndex >= cards.length) {
      return null;
    }

    final currentCard = cards[_currentIndex];
    history.add(
      FlashcardFeedback(isCorrect: feedback, card: _getCard(currentCard)),
    );

    _currentIndex++;

    if (_currentIndex >= cards.length) {
      return null;
    }

    final nextCard = _getCard(cards[_currentIndex]);

    if (_settings.isRepeatWrong && feedback == false) {
      _shuffledCards?.add(currentCard);
    }

    return nextCard;
  }

  Flashcard _getCard(Flashcard card) {
    final newCard = _settings.askLanguage == Languages.ky
        ? card.revert()
        : card;
    return newCard;
  }
}
