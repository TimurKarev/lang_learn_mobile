import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class CardListBloc extends FetchBloc<List<MemoryCardsPreview>, Object> {
  CardListBloc({required MemoryCardsRepository repository})
    : _repository = repository;

  final MemoryCardsRepository _repository;

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> fetchModel(Object? params) {
    return _repository.getMemoryCardsList();
  }

  @override
  FutureOr<void> onFetchError({
    required Failure failure,
    required Emitter<FetchState<List<MemoryCardsPreview>>> emit,
    Object? params,
  }) async {
    emit(
      FetchError<List<MemoryCardsPreview>>(
        error: UiError(
          title: "Что-то пошло не так",
          description:
              "Произошла ошибка при загрузке данных. Проверьте подключение к интернету и попробуйте снова.",
          displayType: ErrorDisplayType.unknown,
          onRetry: () => add(FetchDataEvent(params: params)),
        ),
      ),
    );
  }
}
