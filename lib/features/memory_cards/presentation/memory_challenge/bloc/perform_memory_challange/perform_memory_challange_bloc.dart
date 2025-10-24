import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/performers/memory_card_performer.dart';
import 'package:lang_learn_mobile/core/audio_player/tili_audio_player.dart';

part 'perform_memory_challange_event.dart';
part 'perform_memory_challange_state.dart';

class PerformMemoryChallangeBloc
    extends Bloc<PerformMemoryChallangeEvent, PerformMemoryChallangeState> {
  PerformMemoryChallangeBloc({
    required MemoryChallangePerformer challange,
    required TiliAudioPlayer audioPlayer,
  }) : _challange = challange,
       _audioPlayer = audioPlayer,
       super(PerformMemoryChallangeInitial()) {
    on<PerformMemoryChallangeCardsReadyEvent>(_onCardsReady);
    on<PerformMemoryChallangeSettingsReadyEvent>(_onSettingsReady);
    on<PerformMemoryChallangeDataReadyEvent>(_onDataReady);
    on<PerformMemoryChallangeRestartEvent>(_onRestart);
    on<PerformMemoryChallangeAnswerEvent>(_onAnswer);
    on<PerformMemoryChallangeNextEvent>(_onNext);
    on<PerformMemoryChallangePlayAudioEvent>(_onPlayAudio);
  }

  ChallengeThemes get challengeTheme => _challange.challengeTheme;

  final MemoryChallangePerformer _challange;
  final TiliAudioPlayer _audioPlayer;

  static const _duration = Duration(milliseconds: 300);

  List<FlashcardFeedback?> get history => _challange.history;

  Future<void> _onCardsReady(
    PerformMemoryChallangeCardsReadyEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    if (state case final PerformMemoryChallangeLoading loadingState) {
      if (loadingState.settings != null) {
        add(
          PerformMemoryChallangeDataReadyEvent(
            cards: event.cards,
            settings: loadingState.settings!,
          ),
        );
      } else {
        emit(PerformMemoryChallangeLoading(cards: event.cards));
      }
    } else {
      emit(PerformMemoryChallangeLoading(cards: event.cards));
    }
  }

  Future<void> _onSettingsReady(
    PerformMemoryChallangeSettingsReadyEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    if (state case final PerformMemoryChallangeLoading loadingState) {
      if (loadingState.cards != null) {
        add(
          PerformMemoryChallangeDataReadyEvent(
            cards: loadingState.cards!,
            settings: event.settings,
          ),
        );
      } else {
        emit(PerformMemoryChallangeLoading(settings: event.settings));
      }
    } else {
      emit(PerformMemoryChallangeLoading(settings: event.settings));
    }
  }

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

  Future<void> _onPlayAudio(
    PerformMemoryChallangePlayAudioEvent event,
    Emitter<PerformMemoryChallangeState> emit,
  ) async {
    if (state case final PerformMemoryChallangeAnswer currentState) {
      final result = await _audioPlayer.playAudio(literalId: event.literalId);
      if (result.isLeft) {
        emit(
          PerformMemoryChallangeError(
            currentState.card,
            uiError: UiError(
              title: 'Не удалось воспроизвести аудио',
              displayType: ErrorDisplayType.toast,
              description: '',
            ),
          ),
        );
      }
    }
  }
}
