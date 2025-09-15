import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/history/history_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/settings_page.dart';

/// Centralized route constants and navigation helpers
class AppRoutes {
  // Route path constants
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String challenge = 'challenge';
  static const String information = 'information';
  static const String flashcardHistory = 'flashcard-history';
  static const String flashcardSettings = '/flashcard-settings';

  // Parameter keys
  static const String challengeThemeParam = 'chlangeTheme';

  // Full path templates
  static const String informationPath = '$information/:$challengeThemeParam';
  static const String dashboardPath = dashboard;

  /// Navigation helper methods
  static void goToHome(BuildContext context) {
    context.go(dashboardPath);
  }

  static void goToChallenge(
    BuildContext context, {
    required ChallengeThemes challengeTheme,
  }) {
    context.go(
      '$dashboard/$challenge',
      extra: {'challengeTheme': challengeTheme},
    );
  }

  static void goToInformation(
    BuildContext context, {
    required ChallengeThemes challengeTheme,
  }) {
    if (GoRouterState.of(context).fullPath case final String fullPath) {
      context.push(
        '$fullPath/$information',
        extra: {'challengeTheme': challengeTheme},
      );
    }
  }

  static void goToFlashcardHistory(
    BuildContext context, {
    required List<FlashcardFeedback?> history,
  }) {
    if (GoRouterState.of(context).fullPath case final String fullPath) {
      context.push('$fullPath/$flashcardHistory', extra: {'history': history});
    }
  }

  static Future<bool?> goToSettings(BuildContext context) async {
    return context.push<bool>(flashcardSettings);
  }

  static final router = GoRouter(
    initialLocation: dashboard,
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BlocProvider(
            create: (context) =>
                SettingsBloc(
                  context.read<DiLocator>().get<FlashcardSettingsRepository>(),
                )..add(
                  ModelHandlerFetchEvent<FlashcardsSettings>(
                    params: const FlashcardsSettings.initial(),
                  ),
                ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: dashboard,
            builder: (BuildContext context, GoRouterState state) {
              return const CardsDashboardPage();
            },
            routes: [
              GoRoute(
                path: challenge,
                builder: (BuildContext context, GoRouterState state) {
                  final extra = state.extra as Map<String, dynamic>?;
                  final challengeTheme =
                      extra?['challengeTheme'] as ChallengeThemes?;
                  return MemoryChallengePage(challengeTheme: challengeTheme);
                },
                routes: [
                  GoRoute(
                    path: flashcardHistory,
                    builder: (BuildContext context, GoRouterState state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      final history =
                          extra?['history'] as List<FlashcardFeedback?>?;
                      return HistoryPage(history: history ?? []);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: informationPath,
            builder: (BuildContext context, GoRouterState state) {
              final challengeId = state.pathParameters[challengeThemeParam];
              return InformationPage(challengeId: challengeId!);
            },
          ),
          GoRoute(
            path: flashcardSettings,
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsPage();
            },
          ),
          GoRoute(path: '/', redirect: (context, state) => dashboard),
        ],
      ),
    ],
  );

  /// GoRouter configuration
}
