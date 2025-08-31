import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/numbers_cards.dart';

abstract class MemoryCardsRepository {
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList();
  Future<Either<Failure, List<MemoryCard>>> getMemoryCardsForChallenge(
    String challengeId,
  );
  Future<Either<Failure, Vocabulary>> getInformation(String challengeId);
}

class MemoryCardsRepositoryMock implements MemoryCardsRepository {
  static const _duration = Duration(seconds: 1);

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList() async {
    await Future.delayed(_duration);

    return Right([
      MemoryCardsPreview(
        id: '1',
        title: 'Цифры',
        description: 'Учим кыргызские цифры',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<MemoryCard>>> getMemoryCardsForChallenge(
    String challengeId,
  ) async {
    await Future.delayed(_duration);

    return Right(numbersMemoryCards);
  }

  @override
  Future<Either<Failure, Vocabulary>> getInformation(String challengeId) async {
    await Future.delayed(_duration);

    return Right(Vocabulary(memoryCards: numbersMemoryCards));
  }
}
