import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/bloc/fetch_bloc/fetch_use_case.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc<T extends Object> extends Bloc<FetchEvent<T>, FetchState<T>> {
  FetchBloc(this._fetchUseCase) : super(FetchInitial()) {
    on<FetchEvent<T>>(_onFetch);
  }

  final FetchUseCase<T> _fetchUseCase;

  Future<void> _onFetch(
    FetchEvent<T> event,
    Emitter<FetchState<T>> emit,
  ) async {
    emit(FetchLoading<T>());
    final result = await _fetchUseCase.execute();

    result.fold(
      ifRight: (data) => emit(
        FetchLoaded<T>(data: data),
      ), // You can create a specific error state if needed
      ifLeft: (failure) => emit(FetchError<T>(failure: failure)),
    );
  }
}
