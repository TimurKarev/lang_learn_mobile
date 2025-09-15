import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';

part 'perform_memory_challange_event.dart';
part 'perform_memory_challange_state.dart';

class PerformMemoryChallangeBloc
    extends Bloc<PerformMemoryChallangeEvent, PerformMemoryChallangeState> {
  PerformMemoryChallangeBloc({required MemoryChallangePerformer challange})
    : _challange = challange,
      super(PerformMemoryChallangeInitial()) {
    on<PerformMemoryChallangeDataReadyEvent>(_onDataReady);
    on<PerformMemoryChallangeRestartEvent>(_onRestart);
    on<PerformMemoryChallangeAnswerEvent>(_onAnswer);
    on<PerformMemoryChallangeNextEvent>(_onNext);
  }

  ChallengeThemes get challengeTheme => _challange.challengeTheme;

  final MemoryChallangePerformer _challange;

  static const _duration = Duration(milliseconds: 300);

  List<FlashcardFeedback?> get history => _challange.history;

  Future<void> _onDataReady(
    PerformMemoryChallangeDataReadyEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    emit(PerformMemoryChallangeChooseCard());
    await Future.delayed(_duration);

    _challange.init(cards: event.cards, settings: event.settings);

    if (_challange.startChallange() case final Flashcard card) {
      emit(PerformMemoryChallangeQuestion(card));
    } else {
      emit(PerformMemoryChallangeFinished(history: _challange.history));
    }
  }

  Future<void> _onRestart(
    PerformMemoryChallangeRestartEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    if (_challange.restart(settings: event.settings)
        case final Flashcard card) {
      emit(PerformMemoryChallangeQuestion(card));
    } else {
      emit(PerformMemoryChallangeFinished(history: _challange.history));
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

    final card = _challange.getNextCard(feedback: event.feedback);
    if (card != null) {
      emit(PerformMemoryChallangeQuestion(card));
    } else {
      emit(PerformMemoryChallangeFinished(history: _challange.history));
    }
  }
}
