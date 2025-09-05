part of 'perform_memory_challange_bloc.dart';

sealed class PerformMemoryChallangeState extends Equatable {
  const PerformMemoryChallangeState();

  @override
  List<Object> get props => [];
}

final class PerformMemoryChallangeInitial extends PerformMemoryChallangeState {
  const PerformMemoryChallangeInitial();
}

final class PerformMemoryChallangeError extends PerformMemoryChallangeState {
  const PerformMemoryChallangeError(this.failure);

  final Failure failure;
}

abstract class PerformMemoryChallangeLoaded
    extends PerformMemoryChallangeState {
  const PerformMemoryChallangeLoaded();
}

final class PerformMemoryChallangeChooseCard
    extends PerformMemoryChallangeLoaded {
  const PerformMemoryChallangeChooseCard();
}

final class PerformMemoryChallangeQuestion
    extends PerformMemoryChallangeLoaded {
  const PerformMemoryChallangeQuestion(this.card);

  final MemoryCard card;

  @override
  List<Object> get props => [card];
}

final class PerformMemoryChallangeAnswer extends PerformMemoryChallangeLoaded {
  const PerformMemoryChallangeAnswer(this.card);

  final MemoryCard card;

  @override
  List<Object> get props => [card];
}

final class PerformMemoryChallangeFinished
    extends PerformMemoryChallangeLoaded {
  const PerformMemoryChallangeFinished({required this.history});

  final List<FlashcardFeedback?> history;
}
