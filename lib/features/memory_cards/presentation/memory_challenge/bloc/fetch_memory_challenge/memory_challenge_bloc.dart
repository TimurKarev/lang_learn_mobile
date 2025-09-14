import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class FetchMemoryChallengeBloc extends FetchBloc<List<Flashcard>, String> {
  FetchMemoryChallengeBloc({required MemoryCardsRepository repository})
    : _repository = repository;

  final MemoryCardsRepository _repository;

  @override
  Future<Either<Failure, List<Flashcard>>> fetchModel(String? params) async {
    if (params case final String challengeId) {
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
