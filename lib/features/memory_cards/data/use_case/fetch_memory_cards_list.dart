import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch_bloc/fetch_use_case.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class FetchMemoryCardsList implements FetchUseCase<List<MemoryCardsPreview>> {
  FetchMemoryCardsList(this._repository);

  final MemoryCardsRepository _repository;

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> execute() async {
    final result = await _repository.getMemoryCardsList();
    return result.fold(
      ifLeft: (failure) => Left(failure),
      ifRight: (data) => Right(data),
    );
  }
}
