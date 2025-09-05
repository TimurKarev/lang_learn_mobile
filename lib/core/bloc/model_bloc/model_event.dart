part of 'model_bloc.dart';

class ModelEvent<M extends Object> extends Equatable {
  const ModelEvent();

  @override
  List<Object> get props => [];
}

class InitModelEvent<M extends Object> extends ModelEvent<M> {
  const InitModelEvent(this.model);

  final M model;

  @override
  List<Object> get props => [model];
}
