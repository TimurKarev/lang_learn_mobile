import '../../../domain/entities/memory_card.dart';

abstract class MemoryCardsEvent {
  const MemoryCardsEvent();
}

class LoadMemoryCards extends MemoryCardsEvent {
  const LoadMemoryCards();
}

class AddMemoryCard extends MemoryCardsEvent {
  final String front;
  final String back;

  const AddMemoryCard({required this.front, required this.back});
}

class UpdateMemoryCard extends MemoryCardsEvent {
  final MemoryCard memoryCard;

  const UpdateMemoryCard({required this.memoryCard});
}

class DeleteMemoryCard extends MemoryCardsEvent {
  final String id;

  const DeleteMemoryCard({required this.id});
}

class ReviewMemoryCard extends MemoryCardsEvent {
  final String id;
  final double difficulty;

  const ReviewMemoryCard({required this.id, required this.difficulty});
}
