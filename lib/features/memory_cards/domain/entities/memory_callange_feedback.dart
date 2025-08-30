sealed class MemoryChallangeFeedback {
  const MemoryChallangeFeedback();
}

class DualMemoryChallangeFeedback extends MemoryChallangeFeedback {
  const DualMemoryChallangeFeedback({required this.isCorrect});

  final bool? isCorrect;
}
