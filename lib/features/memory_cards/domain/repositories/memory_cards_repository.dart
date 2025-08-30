import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';

abstract class MemoryCardsRepository {
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList();
  Future<Either<Failure, List<MemoryCard>>> getMemoryCardsForChallenge(
    String challengeId,
  );
}

class MemoryCardsRepositoryMock implements MemoryCardsRepository {
  static const _duration = Duration(seconds: 1);

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList() async {
    await Future.delayed(_duration);

    return Right([
      MemoryCardsPreview(
        id: '1',
        title: 'Basic Spanish',
        description: 'Common phrases and vocabulary',
      ),
      MemoryCardsPreview(
        id: '2',
        title: 'Advanced French',
        description: 'Complex sentences and idioms',
      ),
      MemoryCardsPreview(
        id: '3',
        title: 'German for Travelers',
        description: 'Essential phrases for travel',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<MemoryCard>>> getMemoryCardsForChallenge(
    String challengeId,
  ) async {
    await Future.delayed(_duration);

    return Right([
      MemoryCard(id: '1', front: 'Hello', back: 'Hola'),
      MemoryCard(id: '2', front: 'Thank you', back: 'Gracias'),
      MemoryCard(id: '3', front: 'Goodbye', back: 'Adiós'),
    ]);
  }
}
