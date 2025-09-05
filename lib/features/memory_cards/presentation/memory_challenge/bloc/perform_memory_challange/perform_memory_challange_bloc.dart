import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

part 'perform_memory_challange_event.dart';
part 'perform_memory_challange_state.dart';

class PerformMemoryChallangeBloc
    extends Bloc<PerformMemoryChallangeEvent, PerformMemoryChallangeState> {
  PerformMemoryChallangeBloc({required this.challange})
    : super(PerformMemoryChallangeInitial()) {
    on<PerformMemoryChallangeDataReadyEvent>(_onDataReady);
    on<PerformMemoryChallangeAnswerEvent>(_onAnswer);
    on<PerformMemoryChallangeNextEvent>(_onNext);
  }

  final MemoryChallangePerformer challange;

  static const _duration = Duration(milliseconds: 300);

  Future<void> _onDataReady(
    PerformMemoryChallangeDataReadyEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeChooseCard());
    await Future.delayed(_duration);

    challange.init(event.cards);
    final card = challange.startChallange();
    if (card != null) {
      emit(PerformMemoryChallangeQuestion(card));
    } else {
      emit(PerformMemoryChallangeFinished(history: challange.history));
    }
  }

  Future<void> _onAnswer(
    PerformMemoryChallangeAnswerEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeAnswer(event.card));
  }

  Future<void> _onNext(
    PerformMemoryChallangeNextEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeChooseCard());
    await Future.delayed(_duration);

    final card = challange.getNextCard(feedback: event.feedback);
    if (card != null) {
      emit(PerformMemoryChallangeQuestion(card));
    } else {
      emit(PerformMemoryChallangeFinished(history: challange.history));
    }
  }
}
