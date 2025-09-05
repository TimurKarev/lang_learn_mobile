import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/history/history_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/history_view.dart'
    show HistoryView;
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_page.dart';

/// Centralized route constants and navigation helpers
class AppRoutes {
  // Route path constants
  static const String home = '/';
  static const String challenge = '/challenge';
  static const String information = '/information';
  static const String flashcardHistory = '/flashcard-history';

  // Parameter keys
  static const String challengeIdParam = 'id';

  // Full path templates
  static const String challengePath = '$challenge/:$challengeIdParam';
  static const String informationPath = '$information/:$challengeIdParam';

  /// Generate challenge path with ID
  static String challengeWithId(String challengeId) {
    return '$challenge/$challengeId';
  }

  /// Generate information path with ID
  static String informationWithId(String challengeId) {
    return '$information/$challengeId';
  }

  /// Navigation helper methods
  static void goToHome(BuildContext context) {
    context.go(home);
  }

  static void goToChallenge(
    BuildContext context, {
    required String challengeId,
  }) {
    context.go(challengeWithId(challengeId));
  }

  static void goToInformation(
    BuildContext context, {
    required String challengeId,
  }) {
    context.push(informationWithId(challengeId));
  }

  static void goToFlashcardHistory(
    BuildContext context, {
    required List<FlashcardFeedback?> history,
  }) {
    context.push(flashcardHistory, extra: {'history': history});
  }

  /// GoRouter configuration
  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: home,
        builder: (BuildContext context, GoRouterState state) {
          return const CardsDashboardPage();
        },
        routes: [
          GoRoute(
            path: challengePath,
            builder: (BuildContext context, GoRouterState state) {
              final challengeId = state.pathParameters[challengeIdParam];
              return MemoryChallengePage(challengeId: challengeId);
            },
          ),
          GoRoute(
            path: flashcardHistory,
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra as Map<String, dynamic>?;
              final history = extra?['history'] as List<FlashcardFeedback?>?;
              return HistoryPage(history: history ?? []);
            },
          ),
        ],
      ),
      GoRoute(
        path: informationPath,
        builder: (BuildContext context, GoRouterState state) {
          final challengeId = state.pathParameters[challengeIdParam];
          return InformationPage(challengeId: challengeId!);
        },
      ),
    ],
  );
}
