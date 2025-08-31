sealed class MemoryChallangeFeedback {
  const MemoryChallangeFeedback({required this.cardId});

  final String cardId;
}

class DualMemoryChallangeFeedback extends MemoryChallangeFeedback {
  const DualMemoryChallangeFeedback({
    required super.cardId,
    required this.isCorrect,
  });

  final bool? isCorrect;
}
