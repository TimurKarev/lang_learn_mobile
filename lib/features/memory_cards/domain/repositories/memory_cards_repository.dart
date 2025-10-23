import 'dart:io' show File;

import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_hint.dart'
    show FlashcardHint;
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/household_cards.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/numbers_cards.dart';

abstract class MemoryCardsRepository {
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList();
  Future<Either<Failure, List<Flashcard>>> getMemoryCardsForChallenge(
    ChallengeThemes theme,
  );
  Future<Either<Failure, void>> addHint({
    required String flashcardId,
    required String? hint,
    required File? imageFile,
  });

  Future<Either<Failure, String>> getFlashcardPicureHintUrl({
    required String picPath,
  });
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
    ChallengeThemes theme,
  ) async {
    await Future.delayed(_duration);

    switch (theme) {
      case ChallengeThemes.number:
        return Right(numbersMemoryCards);
      // case ChallengeThemes.greeting:
      //   return Right(greetingsMemoryCards);
      // case ChallengeThemes.pronoun:
      //   return Right(pronounsMemoryCards);
      case ChallengeThemes.household:
        return Right(householdMemoryCards);
      // case ChallengeThemes.verb:
      //   return Right(verbsMemoryCards);
      // case ChallengeThemes.question:
      //   return Right(questionsMemoryCards);
      default:
        return Right([]);
    }
  }

  @override
  Future<Either<Failure, void>> addHint({
    required String flashcardId,
    required String? hint,
    required File? imageFile,
  }) {
    // TODO: implement addHint
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getFlashcardPicureHintUrl({
    required String picPath,
  }) {
    // TODO: implement getFlashcardPicureHintUrl
    throw UnimplementedError();
  }
}
