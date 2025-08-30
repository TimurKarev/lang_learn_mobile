import 'package:bloc/bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

import 'memory_cards_event.dart';
import 'memory_cards_state.dart';

class MemoryCardsBloc extends Bloc<MemoryCardsEvent, MemoryCardsState> {
  final MemoryCardsRepository _repository;

  MemoryCardsBloc({required MemoryCardsRepository repository})
    : _repository = repository,
      super(const MemoryCardsInitial()) {
    on<LoadMemoryCards>(_onLoadMemoryCards);
    on<AddMemoryCard>(_onAddMemoryCard);
    on<UpdateMemoryCard>(_onUpdateMemoryCard);
    on<DeleteMemoryCard>(_onDeleteMemoryCard);
    on<ReviewMemoryCard>(_onReviewMemoryCard);
  }

  Future<void> _onLoadMemoryCards(
    LoadMemoryCards event,
    Emitter<MemoryCardsState> emit,
  ) async {
    emit(const MemoryCardsLoading());
    try {
      final memoryCards = await _repository.getAllMemoryCards();
      emit(MemoryCardsLoaded(memoryCards: memoryCards));
    } catch (e) {
      emit(MemoryCardsError(message: e.toString()));
    }
  }

  Future<void> _onAddMemoryCard(
    AddMemoryCard event,
    Emitter<MemoryCardsState> emit,
  ) async {
    emit(const MemoryCardAdding());
    try {
      final newCard = MemoryCard(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        front: event.front,
        back: event.back,
      );

      await _repository.addMemoryCard(newCard);
      emit(MemoryCardAdded(memoryCard: newCard));

      // Reload all cards to show updated list
      add(const LoadMemoryCards());
    } catch (e) {
      emit(MemoryCardsError(message: e.toString()));
    }
  }

  Future<void> _onUpdateMemoryCard(
    UpdateMemoryCard event,
    Emitter<MemoryCardsState> emit,
  ) async {
    try {
      await _repository.updateMemoryCard(event.memoryCard);
      emit(MemoryCardUpdated(memoryCard: event.memoryCard));

      // Reload all cards to show updated list
      add(const LoadMemoryCards());
    } catch (e) {
      emit(MemoryCardsError(message: e.toString()));
    }
  }

  Future<void> _onDeleteMemoryCard(
    DeleteMemoryCard event,
    Emitter<MemoryCardsState> emit,
  ) async {
    try {
      await _repository.deleteMemoryCard(event.id);
      emit(MemoryCardDeleted(id: event.id));

      // Reload all cards to show updated list
      add(const LoadMemoryCards());
    } catch (e) {
      emit(MemoryCardsError(message: e.toString()));
    }
  }

  Future<void> _onReviewMemoryCard(
    ReviewMemoryCard event,
    Emitter<MemoryCardsState> emit,
  ) async {
    try {
      final card = await _repository.getMemoryCardById(event.id);
      final updatedCard = card.copyWith();

      await _repository.updateMemoryCard(updatedCard);
      emit(MemoryCardUpdated(memoryCard: updatedCard));

      // Reload all cards to show updated list
      add(const LoadMemoryCards());
    } catch (e) {
      emit(MemoryCardsError(message: e.toString()));
    }
  }
}
