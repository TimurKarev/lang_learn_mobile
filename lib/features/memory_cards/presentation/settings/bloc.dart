import 'package:bloc/bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_bloc/model_bloc.dart'
    show ModelBloc, ModelEvent, LoadedModelState, ModelState;
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';

class SettingsBloc extends ModelBloc<FlashcardsSettings> {
  SettingsBloc() : super(model: FlashcardsSettings.initial()) {
    on<SetSomeValueEvent>(_onSetSomeValueEvent);
  }

  Future<void> _onSetSomeValueEvent(
    SetSomeValueEvent event,
    Emitter<ModelState<FlashcardsSettings>> emit,
  ) async {
    final model = FlashcardsSettings(
      shufleCards: true,
      repeatWrong: event.value,
      askLanguage: Languages.russian,
    );

    if (state case final LoadedModelState<FlashcardsSettings> state) {
      emit(state.copyWith(setModel: () => model));
    }
  }
}

class SetSomeValueEvent extends ModelEvent<FlashcardsSettings> {
  const SetSomeValueEvent(this.value);

  final bool value;
}
