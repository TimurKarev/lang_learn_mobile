import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

class InformationBloc extends FetchBloc<Vocabulary, ChallengeThemes> {
  InformationBloc({required MemoryCardsRepository repository})
    : _repository = repository;

  final MemoryCardsRepository _repository;

  @override
  Future<Either<Failure, Vocabulary>> fetchModel(
    ChallengeThemes? params,
  ) async {
    if (params case final ChallengeThemes challengeTheme) {
      final cards = await _repository.getMemoryCardsForChallenge(
        challengeTheme,
      );
      return cards.fold(
        ifLeft: (failure) => Left(failure),
        ifRight: (cards) => Right(Vocabulary(memoryCards: cards)),
      );
    } else {
      return Left(Failure('Challenge ID is required'));
    }
  }
}
