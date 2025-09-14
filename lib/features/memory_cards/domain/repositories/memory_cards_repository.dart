import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/greetings_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/household_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/numbers_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/pronouns_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/questions_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/verbs_cards.dart';

abstract class MemoryCardsRepository {
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList();
  Future<Either<Failure, List<Flashcard>>> getMemoryCardsForChallenge(
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
        theme: ChallengeThemes.number,
      ),
      // MemoryCardsPreview(
      //   id: '2',
      //   title: 'Приветствия и вежливость',
      //   description: 'Основные фразы вежливости на кыргызском',
      // ),
      // MemoryCardsPreview(
      //   id: '3',
      //   title: 'Местоимения',
      //   description: 'Личные местоимения в кыргызском языке',
      // ),
      // MemoryCardsPreview(
      //   id: '4',
      //   title: 'Бытовые слова',
      //   description: 'Слова для повседневной жизни',
      // ),
      // MemoryCardsPreview(
      //   id: '5',
      //   title: 'Глаголы',
      //   description: 'Основные глаголы кыргызского языка',
      // ),
      MemoryCardsPreview(
        id: '6',
        title: 'Вопросы и повседневные фразы',
        description: 'Вопросительные слова и фразы',
        theme: ChallengeThemes.household,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<Flashcard>>> getMemoryCardsForChallenge(
    String challengeId,
  ) async {
    await Future.delayed(_duration);

    switch (challengeId) {
      case '1':
        return Right(numbersMemoryCards);
      case '2':
        return Right(greetingsMemoryCards);
      case '3':
        return Right(pronounsMemoryCards);
      case '4':
        return Right(householdMemoryCards);
      case '5':
        return Right(verbsMemoryCards);
      case '6':
        return Right(questionsMemoryCards);
      default:
        return Right([]);
    }
  }

  @override
  Future<Either<Failure, Vocabulary>> getInformation(String challengeId) async {
    await Future.delayed(_duration);

    switch (challengeId) {
      case '1':
        return Right(Vocabulary(memoryCards: numbersMemoryCards));
      case '2':
        return Right(Vocabulary(memoryCards: greetingsMemoryCards));
      case '3':
        return Right(Vocabulary(memoryCards: pronounsMemoryCards));
      case '4':
        return Right(Vocabulary(memoryCards: householdMemoryCards));
      case '5':
        return Right(Vocabulary(memoryCards: verbsMemoryCards));
      case '6':
        return Right(Vocabulary(memoryCards: questionsMemoryCards));
      default:
        return Right(Vocabulary(memoryCards: []));
    }
  }
}
