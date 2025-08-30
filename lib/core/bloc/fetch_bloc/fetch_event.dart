part of 'fetch_bloc.dart';

sealed class FetchEvent<T> extends Equatable {
  const FetchEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataEvent<T> extends FetchEvent<T> {
  const FetchDataEvent();
}
