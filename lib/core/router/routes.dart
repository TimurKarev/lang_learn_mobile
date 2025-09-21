import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/history/history_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/settings_page.dart';
import 'package:lang_learn_mobile/features/auth/presentation/login_page.dart';
import 'package:lang_learn_mobile/features/onboarding/presentation/onboarding_page.dart';
import 'package:lang_learn_mobile/features/home/presentation/home_page.dart';
import 'package:lang_learn_mobile/features/splash/presentation/splash_page.dart';

/// Centralized route constants and navigation helpers
class AppRoutes {
  // Route path constants
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String challenge = 'challenge';
  static const String information = '/information';
  static const String flashcardSettings = '/flashcard-settings';
  static const String flashcardHistory = 'flashcard-history';

  // Parameter keys

  /// Navigation helper methods
  static void goToHome(BuildContext context) {
    context.go(dashboard);
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
    context.push(information, extra: {'challengeTheme': challengeTheme});
  }

  static Future<bool?> goToSettings(BuildContext context) async {
    return context.push<bool>(flashcardSettings);
  }

  static void goToFlashcardHistory(
    BuildContext context, {
    required List<FlashcardFeedback?> history,
  }) {
    if (GoRouterState.of(context).fullPath case final String fullPath) {
      context.push('$fullPath/$flashcardHistory', extra: {'history': history});
    }
  }

  static GoRouter router(Listenable listenable) {
    debugPrint('Router initialized with listenable: $listenable');
    
    return GoRouter(
      refreshListenable: listenable,
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      redirect: (BuildContext context, GoRouterState state) {
        debugPrint('Redirect called with location: ${state.uri}');
        final user = context.read<AuthBloc>().state;
        final location = state.uri.path;
        
        debugPrint('Current auth state: $user');
        debugPrint('Current location: $location');

        // Always allow splash screen
        if (location == '/splash') return null;

        // If we're on login/onboarding and user is authenticated, go home
        if (user is AuthenticatedUser &&
            (location == '/login' || location == '/onboarding')) {
          return '/home';
        }

        // If user is not authenticated, only allow them to access login or onboarding.
        final isGoingToPublicRoute = location == '/login' || location == '/onboarding';
        if (user is UnauthenticatedUser && !isGoingToPublicRoute) {
          // The SplashBloc should have already decided between login and onboarding.
          // This redirect is a fallback for other cases.
          return '/login';
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return BlocProvider(
              create: (context) => SettingsBloc(
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
              path: information,
              builder: (BuildContext context, GoRouterState state) {
                final extra = state.extra as Map<String, dynamic>?;
                final challengeTheme =
                    extra?['challengeTheme'] as ChallengeThemes?;
                return InformationPage(challengeTheme: challengeTheme);
              },
            ),
            GoRoute(
              path: flashcardSettings,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsPage();
              },
            ),
            GoRoute(
              path: '/',
              redirect: (context, state) => dashboard,
            ),
          ],
        ),
      ],
    );
  }
}
