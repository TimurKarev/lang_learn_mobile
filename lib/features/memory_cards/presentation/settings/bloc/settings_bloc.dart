import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/initial_model_mixin.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';

class SettingsBloc extends ModelHandlerBloc<FlashcardsSettings, Object?>
    with SettingsChangeTracker<FlashcardsSettings> {
  SettingsBloc() : super() {
    on<ShuffleCardsChangesSettingsEvent>(_onShuffleCardsChange);
    on<RepeatWrongChangesSettingsEvent>(_onRepeatWrongChange);
    on<AskLanguageChangesSettingsEvent>(_onAskLanguageChange);
    on<ApplySettingsEvent>(_onApplySettings);
  }

  @override
  Future<Either<Failure, FlashcardsSettings>> fetchModel(Object? params) async {
    return Left(Failure('Not implemented'));
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
        shufleCards: event.value,
        repeatWrong: state.model.repeatWrong,
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
        shufleCards: state.model.shufleCards,
        repeatWrong: event.value,
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
        shufleCards: state.model.shufleCards,
        repeatWrong: state.model.repeatWrong,
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
      add(ModelHandlerSetModelEvent(state.model));
    } else {
      throw UnimplementedError();
    }
  }
}

class ShuffleCardsChangesSettingsEvent extends ModelHandlerEvent {
  const ShuffleCardsChangesSettingsEvent(this.value);

  final bool value;
}

class RepeatWrongChangesSettingsEvent extends ModelHandlerEvent {
  const RepeatWrongChangesSettingsEvent(this.value);

  final bool value;
}

class AskLanguageChangesSettingsEvent extends ModelHandlerEvent {
  const AskLanguageChangesSettingsEvent(this.value);

  final Languages value;
}

class ApplySettingsEvent extends ModelHandlerEvent {
  const ApplySettingsEvent();
}
