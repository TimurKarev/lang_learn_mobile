import '../../domain/entities/memory_card.dart';
import '../../domain/repositories/memory_cards_repository.dart';

class MemoryCardsRepositoryImpl implements MemoryCardsRepository {
  // In-memory storage for demonstration
  // In a real app, this would be replaced with local database or API calls
  final List<MemoryCard> _memoryCards = [
    MemoryCard(id: '1', front: 'Hello', back: 'Hola'),
    MemoryCard(id: '2', front: 'Goodbye', back: 'Adiós'),
    MemoryCard(id: '3', front: 'Thank you', back: 'Gracias'),
  ];

  @override
  Future<List<MemoryCard>> getAllMemoryCards() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_memoryCards);
  }

  @override
  Future<MemoryCard> getMemoryCardById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final card = _memoryCards.firstWhere(
      (card) => card.id == id,
      orElse: () => throw Exception('Memory card not found'),
    );
    return card;
  }

  @override
  Future<void> addMemoryCard(MemoryCard memoryCard) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _memoryCards.add(memoryCard);
  }

  @override
  Future<void> updateMemoryCard(MemoryCard memoryCard) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _memoryCards.indexWhere((card) => card.id == memoryCard.id);
    if (index != -1) {
      _memoryCards[index] = memoryCard;
    } else {
      throw Exception('Memory card not found');
    }
  }

  @override
  Future<void> deleteMemoryCard(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _memoryCards.indexWhere((card) => card.id == id);
    if (index != -1) {
      _memoryCards.removeAt(index);
    } else {
      throw Exception('Memory card not found');
    }
  }
}
