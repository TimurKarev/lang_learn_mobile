import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
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
  static const String dashboard = 'dashboard';
  static const String challenge = 'challenge';
  static const String information = '/information';
  static const String flashcardHistory = 'flashcard-history';
  static const String settings = 'settings';

  // Parameter keys
  static const String challengeIdParam = 'id';

  // Full path templates
  static const String challengePath = '$challenge/:$challengeIdParam';
  static const String informationPath = '$information/:$challengeIdParam';
  static const String dashboardPath = dashboard;

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
    context.go(dashboardPath);
  }

  static void goToChallenge(
    BuildContext context, {
    required String challengeId,
  }) {
    context.go('/$dashboard/$challenge/$challengeId');
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
    if (GoRouterState.of(context).fullPath case final String fullPath) {
      context.push('$fullPath/$flashcardHistory', extra: {'history': history});
    }
  }

  static Future<bool?> goToSettings(BuildContext context) async {
    if (GoRouterState.of(context).fullPath case final String fullPath) {
      return context.push<bool>('$fullPath/$settings');
    }
    return false;
  }

  static final router = GoRouter(
    initialLocation: '/$dashboard',
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BlocProvider(
            create: (context) => SettingsBloc()
              ..add(
                ModelHandlerSetModelEvent<FlashcardsSettings>(
                  FlashcardsSettings.initial(),
                ),
              ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/$dashboard',
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
                  GoRoute(
                    path: settings,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SettingsPage();
                    },
                  ),
                ],
              ),
              GoRoute(
                path: settings,
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsPage();
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
          GoRoute(path: '/', redirect: (context, state) => '/$dashboard'),
        ],
      ),
    ],
  );

  /// GoRouter configuration
}
