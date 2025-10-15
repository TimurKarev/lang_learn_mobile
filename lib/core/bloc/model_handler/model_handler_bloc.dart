import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';

part 'model_handler_event.dart';
part 'model_handler_state.dart';

abstract class ModelHandlerBloc<M extends Object, P extends Object>
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

  void onSetModel(M model) {}

  FutureOr<void> onFetchError({
    required Failure failure,
    required Emitter<ModelHandlerState<M>> emit,
    P? params,
  }) async {
    emit(
      ModelHandlerError<M>(
        uiError: UiError(
          title: "Что-то пошло не так",
          description:
              "Произошла ошибка при загрузке данных. Проверьте подключение к интернету и попробуйте снова.",
          displayType: ErrorDisplayType.unknown,
          onRetry: () => add(ModelHandlerFetchEvent<P>(params)),
        ),
      ),
    );
  }

  Future<void> _onFetch(
    ModelHandlerFetchEvent<P> event,
    Emitter<ModelHandlerState<M>> emit,
  ) async {
    emit(ModelHandlerLoading<M>());
    final result = await fetchModel(event.params);

    result.fold(
      ifRight: (data) {
        emit(ModelHandlerLoaded<M>(model: data));
        onSetModel(data);
      },
      ifLeft: (failure) =>
          onFetchError(failure: failure, emit: emit, params: event.params),
    );
  }

  Future<void> _onSetModel(
    ModelHandlerSetModelEvent<M> event,
    Emitter<ModelHandlerState<M>> emit,
  ) async {
    emit(ModelHandlerLoaded<M>(model: event.model));
    if (event.needOnSetModel) {
      onSetModel(event.model);
    }
  }
}
