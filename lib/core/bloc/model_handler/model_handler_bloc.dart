import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';

part 'model_handler_event.dart';
part 'model_handler_state.dart';

abstract class ModelHandlerBloc<M extends Object, P extends Object?>
    extends Bloc<ModelHandlerEvent, ModelHandlerState<M>> {
  ModelHandlerBloc({M? initModel})
    : super(
        initModel != null
            ? ModelHandlerLoaded(model: initModel)
            : ModelHandlerInitial(),
      ) {
    on<ModelHandlerFetchEvent<P>>(_onFetch);
    on<ModelHandlerSetModelEvent<M>>(_onSetModel);
  }

  Future<Either<Failure, M>> fetchModel(P? params);

  Future<void> _onFetch(
    ModelHandlerFetchEvent<P> event,
    Emitter<ModelHandlerState<M>> emit,
  ) async {
    emit(ModelHandlerLoading<M>());
    final result = await fetchModel(event.params);

    result.fold(
      ifRight: (data) => emit(ModelHandlerLoaded<M>(model: data)),
      ifLeft: (failure) => emit(ModelHandlerError<M>(failure: failure)),
    );
  }

  Future<void> _onSetModel(
    ModelHandlerSetModelEvent<M> event,
    Emitter<ModelHandlerState<M>> emit,
  ) async {
    emit(ModelHandlerLoaded<M>(model: event.model));
  }
}
