import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/initial_model_mixin.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';

part 'settings_event.dart';

class SettingsBloc
    extends ModelHandlerBloc<FlashcardsSettings, FlashcardsSettings>
    with SettingsChangeTracker<FlashcardsSettings, FlashcardsSettings> {
  SettingsBloc(this._repository) : super() {
    on<ShuffleCardsChangesSettingsEvent>(_onShuffleCardsChange);
    on<RepeatWrongChangesSettingsEvent>(_onRepeatWrongChange);
    on<AskLanguageChangesSettingsEvent>(_onAskLanguageChange);
    on<ApplySettingsEvent>(_onApplySettings);
    on<CancelSettingsEvent>(_onCancelSettings);
  }

  final FlashcardSettingsRepository _repository;

  @override
  Future<Either<Failure, FlashcardsSettings>> fetchModel(
    FlashcardsSettings? params,
  ) async {
    if (params case final FlashcardsSettings settings) {
      return _repository.getSettings(defaultSettings: settings);
    } else {
      return Left(Failure('Settings are required'));
    }
  }

  @override
  void onSetModel(FlashcardsSettings model) {
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
      );
      emit(state.copyWith(model: model));
    } else {
      throw UnimplementedError();
    }
  }

  Future<void> _onApplySettings(
    ApplySettingsEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      if (state.model != getInitialModel()) {
        await _repository.saveSettings(state.model);
      }
      add(ModelHandlerSetModelEvent(state.model));
    } else {
      throw UnimplementedError();
    }
  }

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
