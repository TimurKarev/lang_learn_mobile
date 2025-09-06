import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_use_case.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class FetchInformation implements FetchUseCase<Vocabulary> {
  FetchInformation(this._repository, this._challengeId);

  final MemoryCardsRepository _repository;
  final String _challengeId;

  @override
  Future<Either<Failure, Vocabulary>> execute() async {
    final result = await _repository.getInformation(_challengeId);
    return result.fold(
      ifLeft: (failure) => Left(failure),
      ifRight: (data) => Right(data),
    );
  }
}
