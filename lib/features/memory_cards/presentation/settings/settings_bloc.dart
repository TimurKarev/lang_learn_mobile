import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';

class SettingsBloc extends ModelHandlerBloc<FlashcardsSettings, Object?> {
  SettingsBloc() : super() {
    on<SetSomeValueEvent>(_onSetSomeValueEvent);
  }

  Future<void> _onSetSomeValueEvent(
    SetSomeValueEvent event,
    Emitter<ModelHandlerState<FlashcardsSettings>> emit,
  ) async {
    final model = FlashcardsSettings(
      shufleCards: true,
      repeatWrong: event.value,
      askLanguage: Languages.russian,
    );

    if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
      emit(state.copyWith(model: model));
    }
  }

  @override
  Future<Either<Failure, FlashcardsSettings>> fetchModel(Object? params) async {
    return Left(Failure('Not implemented'));
  }
}

class SetSomeValueEvent extends ModelHandlerEvent {
  const SetSomeValueEvent(this.value);

  final bool value;
}
