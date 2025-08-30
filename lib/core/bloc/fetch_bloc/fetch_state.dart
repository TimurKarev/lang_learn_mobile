part of 'fetch_bloc.dart';

sealed class FetchState<T extends Object> extends Equatable {
  const FetchState();

  @override
  List<Object> get props => [];
}

final class FetchInitial<T extends Object> extends FetchState<T> {
  const FetchInitial();
}

final class FetchLoading<T extends Object> extends FetchState<T> {
  const FetchLoading();
}

final class FetchError<T extends Object> extends FetchState<T> {
  const FetchError({required this.failure});

  final Failure failure;
}

final class FetchLoaded<T extends Object> extends FetchState<T> {
  final T data;

  const FetchLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
