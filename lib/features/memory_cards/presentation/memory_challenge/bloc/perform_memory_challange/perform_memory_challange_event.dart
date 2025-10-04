part of 'perform_memory_challange_bloc.dart';

sealed class PerformMemoryChallangeEvent extends Equatable {
  const PerformMemoryChallangeEvent();

  @override
  List<Object> get props => [];
}

final class PerformMemoryChallangeCardsReadyEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeCardsReadyEvent({required this.cards});

  final List<Flashcard> cards;
}

final class PerformMemoryChallangeSettingsReadyEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeSettingsReadyEvent({required this.settings});

  final FlashcardsSettings settings;
}

final class PerformMemoryChallangeDataReadyEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeDataReadyEvent({
    required this.cards,
    required this.settings,
  });

  final List<Flashcard> cards;
  final FlashcardsSettings settings;
}

class PerformMemoryChallangeRestartEvent extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeRestartEvent({required this.settings});

  final FlashcardsSettings settings;
}

final class PerformMemoryChallangeAnswerEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeAnswerEvent(this.card);

  final Flashcard card;
}

final class PerformMemoryChallangeNextEvent
    extends PerformMemoryChallangeEvent {
  const PerformMemoryChallangeNextEvent({required this.feedback});

  final bool? feedback;
}
