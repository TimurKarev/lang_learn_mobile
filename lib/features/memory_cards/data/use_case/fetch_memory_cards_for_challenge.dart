import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_use_case.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class FetchMemoryCardsForChallenge implements FetchUseCase<List<MemoryCard>> {
  FetchMemoryCardsForChallenge(this._repository, this._challengeId);

  final MemoryCardsRepository _repository;
  final String? _challengeId;

  @override
  Future<Either<Failure, List<MemoryCard>>> execute() async {
    if (_challengeId case final String challengeId) {
      final result = await _repository.getMemoryCardsForChallenge(challengeId);
      return result.fold(
        ifLeft: (failure) => Left(failure),
        ifRight: (data) => Right(data),
      );
    } else {
      return Left(Failure('Challenge ID is required'));
    }
  }
}
