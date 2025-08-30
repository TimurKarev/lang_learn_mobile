part of 'perform_memory_challange_bloc.dart';

sealed class PerformMemoryChallangeEvent extends Equatable {
  const PerformMemoryChallangeEvent();

  @override
  List<Object> get props => [];
}

final class PerformMemoryChallangeDataReadyEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeDataReadyEvent(this.cards);

  final List<MemoryCard> cards;
}

final class PerformMemoryChallangeNextEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeNextEvent(this.feedback);

  final MemoryChallangeFeedback feedback;
}
