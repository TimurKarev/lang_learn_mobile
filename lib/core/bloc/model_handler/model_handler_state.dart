part of 'model_handler_bloc.dart';

sealed class ModelHandlerState<M extends Object> extends Equatable {
  const ModelHandlerState();

  @override
  List<Object> get props => [];
}

final class ModelHandlerInitial<M extends Object> extends ModelHandlerState<M> {
  const ModelHandlerInitial();
}

final class ModelHandlerLoading<M extends Object> extends ModelHandlerState<M> {
  const ModelHandlerLoading();
}

final class ModelHandlerError<M extends Object> extends ModelHandlerState<M> {
  const ModelHandlerError({required this.uiError});

  final UiError uiError;
}

final class ModelHandlerLoaded<M extends Object> extends ModelHandlerState<M> {
  const ModelHandlerLoaded({required this.model});

  ModelHandlerLoaded<M> copyWith({M? model}) {
    return ModelHandlerLoaded<M>(model: model ?? this.model);
  }

  final M model;

  @override
  List<Object> get props => [model];
}
