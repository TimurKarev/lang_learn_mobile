import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/router/paths.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';

class TiliNavigation {
  void goToVocablaryDashboard(BuildContext context) {
    context.pushNamed(Paths.vocabularyDashboard.name);
  }

  void goToChallenge(
    BuildContext context, {
    required ChallengeThemes challengeTheme,
  }) {
    context.pushNamed(Paths.vocabularyChallenge.name, extra: challengeTheme);
  }

  void pushVocabularyInformation(
    BuildContext context, {
    required ChallengeThemes challengeTheme,
  }) {
    context.pushNamed(
      Paths.vocabularyChallengeInformation.name,
      extra: challengeTheme,
    );
  }

  Future<FlashcardsSettings?> pushVocabluraySettings(
    BuildContext context, {
    required FlashcardsSettings? settings,
  }) async {
    return context.pushNamed<FlashcardsSettings>(
      Paths.vocabularyChallengeSettings.name,
      extra: settings,
    );
  }

  void goToFlashcardHistory(
    BuildContext context, {
    required List<FlashcardFeedback?> history,
  }) {
    context.pushNamed(Paths.vocabularyChallengeHistory.name, extra: history);
  }
}
