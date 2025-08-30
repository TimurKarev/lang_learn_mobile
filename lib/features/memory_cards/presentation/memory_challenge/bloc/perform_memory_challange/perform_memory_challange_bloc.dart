import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_callange_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

part 'perform_memory_challange_event.dart';
part 'perform_memory_challange_state.dart';

class PerformMemoryChallangeBloc
    extends Bloc<PerformMemoryChallangeEvent, PerformMemoryChallangeState> {
  PerformMemoryChallangeBloc({required this.challange})
    : super(PerformMemoryChallangeInitial()) {
    on<PerformMemoryChallangeDataReadyEvent>(_onDataReady);
    on<PerformMemoryChallangeNextEvent>(_onNext);
  }

  final MemoryChallangePerformer challange;

  Future<void> _onDataReady(
    PerformMemoryChallangeDataReadyEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeChooseCard());
    challange.init(event.cards);
    final card = challange.getNextCard(feedback: null);
    if (card != null) {
      emit(PerformMemoryChallangeCardReady(card));
    } else {
      emit(PerformMemoryChallangeFinished());
    }
  }

  Future<void> _onNext(
    PerformMemoryChallangeNextEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeChooseCard());
    final card = challange.getNextCard(feedback: event.feedback);
    if (card != null) {
      emit(PerformMemoryChallangeCardReady(card));
    } else {
      emit(PerformMemoryChallangeFinished());
    }
  }
}
