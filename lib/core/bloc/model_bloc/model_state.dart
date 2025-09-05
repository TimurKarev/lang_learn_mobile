part of 'model_bloc.dart';

sealed class ModelState<M> extends Equatable {
  const ModelState();

  @override
  List<Object?> get props => [];
}

class InitialModelState<M> extends ModelState<M> {
  const InitialModelState();
}

class LoadedModelState<M> extends ModelState<M> {
  const LoadedModelState({this.model});

  final M? model;

  LoadedModelState<M> copyWith({M? Function()? setModel}) {
    return LoadedModelState<M>(
      model: setModel != null ? setModel.call() : this.model,
    );
  }

  @override
  List<Object?> get props => [model];
}

class ErrorModelState<M> extends ModelState<M> {
  const ErrorModelState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
