import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart' show Either;
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

abstract class FetchBloc<T extends Object, P extends Object>
    extends Bloc<FetchEvent, FetchState<T>> {
  FetchBloc() : super(FetchInitial()) {
    on<FetchDataEvent<P>>(_onFetch);
  }

  Future<Either<Failure, T>> fetchModel(P? params);

  FutureOr<void> onFetchError({
    required Failure failure,
    required Emitter<FetchState<T>> emit,
    P? params,
  }) {
    emit(
      FetchError<T>(
        error: UiError(
          title: "Что-то пошло не так",
          description:
              "Произошла ошибка при загрузке данных. Проверьте подключение к интернету и попробуйте снова.",
          displayType: ErrorDisplayType.unknown,
          onRetry: () => add(FetchDataEvent<P>(params: params)),
        ),
      ),
    );
  }

  Future<void> _onFetch(
    FetchDataEvent<P> event,
    Emitter<FetchState<T>> emit,
  ) async {
    emit(FetchLoading<T>());
    final result = await fetchModel(event.params);

    result.fold(
      ifRight: (data) => emit(FetchLoaded<T>(data: data)),
      ifLeft: (failure) =>
          onFetchError(failure: failure, emit: emit, params: event.params),
    );
  }
}
