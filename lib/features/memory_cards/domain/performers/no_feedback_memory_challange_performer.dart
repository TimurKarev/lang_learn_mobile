import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_callange_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

class NoFeedbackMemoryChallangePerformer extends MemoryChallangePerformer {
  NoFeedbackMemoryChallangePerformer();

  List<MemoryCard>? _shuffledCards;
  int _currentIndex = 0;

  @override
  void init(List<MemoryCard> cards) {
    _shuffledCards = List<MemoryCard>.from(cards)..shuffle();
    _currentIndex = 0;
  }

  @override
  MemoryCard? getNextCard({MemoryChallangeFeedback? feedback}) {
    if (_currentIndex >= _shuffledCards!.length) {
      return null;
    }

    final card = _shuffledCards?[_currentIndex];
    _currentIndex++;
    return card;
  }

  bool get hasMoreCards {
    if (_shuffledCards?.length case final int length) {
      return _currentIndex < length;
    }
    return false;
  }

  int get remainingCards {
    if (_shuffledCards?.length case final int length) {
      return length - _currentIndex;
    }
    return 0;
  }

  int get totalCards {
    if (_shuffledCards?.length case final int length) {
      return length;
    }
    return 0;
  }
}
