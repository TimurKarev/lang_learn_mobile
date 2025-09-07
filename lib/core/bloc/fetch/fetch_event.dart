part of 'fetch_bloc.dart';

sealed class FetchEvent extends Equatable {
  const FetchEvent();

  @override
  List<Object?> get props => [];
}

final class FetchDataEvent<P> extends FetchEvent {
  const FetchDataEvent({this.params});

  final P? params;

  @override
  List<Object?> get props => [params];
}
