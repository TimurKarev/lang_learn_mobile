import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc<M extends Object> extends Bloc<ModelEvent<M>, ModelState<M>> {
  ModelBloc({M? model})
    : super(
        model != null
            ? LoadedModelState<M>(model: model)
            : InitialModelState<M>(),
      ) {
    on<InitModelEvent<M>>(_onInitModel);
  }

  Future<void> _onInitModel(
    InitModelEvent<M> event,
    Emitter<ModelState<M>> emit,
  ) async {
    emit(LoadedModelState<M>(model: event.model));
  }
}
