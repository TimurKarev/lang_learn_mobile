import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';

abstract class MemoryCardsRepository {
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList();
}

class MemoryCardsRepositoryMock implements MemoryCardsRepository {
  static const _duration = Duration(seconds: 1);

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList() async {
    await Future.delayed(_duration);

    return Right([
      MemoryCardsPreview(
        title: 'Basic Spanish',
        description: 'Common phrases and vocabulary',
      ),
      MemoryCardsPreview(
        title: 'Advanced French',
        description: 'Complex sentences and idioms',
      ),
      MemoryCardsPreview(
        title: 'German for Travelers',
        description: 'Essential phrases for travel',
      ),
    ]);
  }
}
