part of 'model_handler_bloc.dart';

class ModelHandlerEvent extends Equatable {
  const ModelHandlerEvent();

  @override
  List<Object> get props => [];
}

final class ModelHandlerFetchEvent<P extends Object?>
    extends ModelHandlerEvent {
  const ModelHandlerFetchEvent({this.params});

  final P? params;
}

final class ModelHandlerSetModelEvent<M extends Object>
    extends ModelHandlerEvent {
  const ModelHandlerSetModelEvent(this.model);

  final M model;
}
