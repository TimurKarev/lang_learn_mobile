import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/initial_model_mixin.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';

part 'settings_event.dart';

class SettingsBloc extends ModelHandlerBloc<FlashcardsSettings, Object>
    with SettingsChangeTracker<FlashcardsSettings, Object> {
  SettingsBloc(this._repository) : super() {
    on<ShuffleCardsChangesSettingsEvent>(_onShuffleCardsChange);
    on<RepeatWrongChangesSettingsEvent>(_onRepeatWrongChange);
    on<AskLanguageChangesSettingsEvent>(_onAskLanguageChange);
    on<ShowHintChangesSettingsEvent>(_onShowHintChange);
    // on<ApplySettingsEvent>(_onApplySettings);
    on<CancelSettingsEvent>(_onCancelSettings);
  }

  final FlashcardSettingsRepository _repository;

  @override
  Future<Either<Failure, FlashcardsSettings>> fetchModel(Object? params) async {
    final result = await _repository.getSettings();

    return result.fold(
      ifLeft: (failure) => Right(FlashcardsSettings.initial()),
      ifRight: (data) => Right(data),
    );
  }

  @override
  Future<void> onSetModel(FlashcardsSettings model) async {
    await _repository.saveSettings(model);
    setInitialModel(model);
  }

  Future<void> _onShuffleCardsChange(
    ShuffleCardsChangesSettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      final model = FlashcardsSettings(
        isShufleCards: event.value,
        isRepeatWrong: state.model.isRepeatWrong,
        askLanguage: state.model.askLanguage,
        isShowHint: state.model.isShowHint,
      );
      emit(state.copyWith(model: model));
    } else {
      throw UnimplementedError();
    }
  }

  Future<void> _onRepeatWrongChange(
    RepeatWrongChangesSettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      final model = FlashcardsSettings(
        isShufleCards: state.model.isShufleCards,
        isRepeatWrong: event.value,
        askLanguage: state.model.askLanguage,
        isShowHint: state.model.isShowHint,
      );
      emit(state.copyWith(model: model));
    } else {
      throw UnimplementedError();
    }
  }

  Future<void> _onAskLanguageChange(
    AskLanguageChangesSettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      final model = FlashcardsSettings(
        isShufleCards: state.model.isShufleCards,
        isRepeatWrong: state.model.isRepeatWrong,
        askLanguage: event.value,
        isShowHint: state.model.isShowHint,
      );
      emit(state.copyWith(model: model));
    } else {
      throw UnimplementedError();
    }
  }

  Future<void> _onShowHintChange(
    ShowHintChangesSettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      final model = FlashcardsSettings(
        isShufleCards: state.model.isShufleCards,
        isRepeatWrong: state.model.isRepeatWrong,
        askLanguage: state.model.askLanguage,
        isShowHint: event.value,
      );
      emit(state.copyWith(model: model));
    } else {
      throw UnimplementedError();
    }
  }

  // Future<void> _onApplySettings(
  //   ApplySettingsEvent event,
  //   Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  // ) async {
  //   if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
  //     if (state.model != getInitialModel()) {
  //       await _repository.saveSettings(state.model);
  //     }
  //     add(ModelHandlerSetModelEvent(state.model));
  //   } else {
  //     throw UnimplementedError();
  //   }
  // }

  Future<void> _onCancelSettings(
    CancelSettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      emit(state.copyWith(model: getInitialModel()));
    } else {
      throw UnimplementedError();
    }
  }
}
