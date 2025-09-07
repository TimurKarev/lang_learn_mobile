import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart' show Either;
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

abstract class FetchBloc<T extends Object, P extends Object>
    extends Bloc<FetchEvent, FetchState<T>> {
  FetchBloc() : super(FetchInitial()) {
    on<FetchDataEvent<P>>(_onFetch);
  }

  Future<Either<Failure, T>> fetchModel(P? params);

  Future<void> _onFetch(
    FetchDataEvent<P> event,
    Emitter<FetchState<T>> emit,
  ) async {
    emit(FetchLoading<T>());
    final result = await fetchModel(event.params);

    result.fold(
      ifRight: (data) => emit(FetchLoaded<T>(data: data)),
      ifLeft: (failure) => emit(FetchError<T>(failure: failure)),
    );
  }
}
