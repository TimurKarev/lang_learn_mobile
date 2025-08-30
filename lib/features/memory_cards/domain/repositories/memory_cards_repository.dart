import '../entities/memory_card.dart';

abstract class MemoryCardsRepository {
  Future<List<MemoryCard>> getAllMemoryCards();
  Future<MemoryCard> getMemoryCardById(String id);
  Future<void> addMemoryCard(MemoryCard memoryCard);
  Future<void> updateMemoryCard(MemoryCard memoryCard);
  Future<void> deleteMemoryCard(String id);
}
