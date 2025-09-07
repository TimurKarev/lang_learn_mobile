import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
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
}
