import '../../../domain/entities/memory_card.dart';

abstract class MemoryCardsState {
  const MemoryCardsState();
}

class MemoryCardsInitial extends MemoryCardsState {
  const MemoryCardsInitial();
}

class MemoryCardsLoading extends MemoryCardsState {
  const MemoryCardsLoading();
}

class MemoryCardsLoaded extends MemoryCardsState {
  final List<MemoryCard> memoryCards;

  const MemoryCardsLoaded({required this.memoryCards});
}

class MemoryCardsError extends MemoryCardsState {
  final String message;

  const MemoryCardsError({required this.message});
}

class MemoryCardAdding extends MemoryCardsState {
  const MemoryCardAdding();
}

class MemoryCardAdded extends MemoryCardsState {
  final MemoryCard memoryCard;

  const MemoryCardAdded({required this.memoryCard});
}

class MemoryCardUpdated extends MemoryCardsState {
  final MemoryCard memoryCard;

  const MemoryCardUpdated({required this.memoryCard});
}

class MemoryCardDeleted extends MemoryCardsState {
  final String id;

  const MemoryCardDeleted({required this.id});
}
