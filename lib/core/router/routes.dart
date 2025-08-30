import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_page.dart';

/// Centralized route constants and navigation helpers
class AppRoutes {
  // Route path constants
  static const String home = '/';
  static const String challenge = '/challenge';

  // Parameter keys
  static const String challengeIdParam = 'id';

  // Full path templates
  static const String challengePath = '$challenge/:$challengeIdParam';

  /// Generate challenge path with ID
  static String challengeWithId(String challengeId) {
    return '$challenge/$challengeId';
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
        ],
      ),
    ],
  );
}
