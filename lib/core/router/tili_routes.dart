import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/router/codecs/combined_codec.dart';
import 'package:lang_learn_mobile/core/router/paths.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/history/history_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_page.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/flashcards_settings_page.dart';
import 'package:lang_learn_mobile/features/auth/presentation/login_page.dart';
import 'package:lang_learn_mobile/features/auth/presentation/terms_of_use_page.dart';
import 'package:lang_learn_mobile/features/auth/presentation/privacy_policy_page.dart';
import 'package:lang_learn_mobile/features/onboarding/presentation/onboarding_page.dart';
import 'package:lang_learn_mobile/features/home/presentation/home_page.dart';
import 'package:lang_learn_mobile/features/splash/presentation/splash_page.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_placeholder.dart';

/// Centralized route constants and navigation helpers
class TiliRoutes {
  static GoRouter router(Listenable listenable) {
    return GoRouter(
      refreshListenable: listenable,
      initialLocation: Paths.splash.path,
      debugLogDiagnostics: true,
      extraCodec: const CombinedCodec(),
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

        // If user is not authenticated, only allow them to access login, onboarding, terms of use, or privacy policy.
        final isGoingToPublicRoute =
            location == '/login' ||
            location == '/onboarding' ||
            location == '/terms-of-use' ||
            location == '/privacy-policy';
        if (user is UnauthenticatedUser && !isGoingToPublicRoute) {
          // The SplashBloc should have already decided between login and onboarding.
          // This redirect is a fallback for other cases.
          return '/login';
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: Paths.error.path,
          name: Paths.error.name,
          builder: (BuildContext context, GoRouterState state) {
            final error = state.extra as UiError?;
            // TODO: move to Page
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: ErrorPlaceholder(
                    error:
                        error ??
                        const UiError(
                          title: 'Unknown Error',
                          description: 'An unknown error occurred',
                          displayType: ErrorDisplayType.screen,
                        ),
                  ),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: Paths.splash.path,
          name: Paths.splash.name,
          builder: (context, state) => const SplashPage(),
          routes: [
            GoRoute(
              path: Paths.login.path,
              name: Paths.login.name,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: Paths.onboarding.path,
              name: Paths.onboarding.name,
              builder: (context, state) => const OnboardingPage(),
            ),
          ],
        ),
        GoRoute(
          path: Paths.termsOfUse.path,
          name: Paths.termsOfUse.name,
          builder: (context, state) => const TermsOfUsePage(),
        ),
        GoRoute(
          path: Paths.privacyPolicy.path,
          name: Paths.privacyPolicy.name,
          builder: (context, state) => const PrivacyPolicyPage(),
        ),
        GoRoute(
          path: Paths.home.path,
          name: Paths.home.name,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: Paths.vocabularyDashboard.path,
              name: Paths.vocabularyDashboard.name,
              builder: (BuildContext context, GoRouterState state) {
                return const CardsDashboardPage();
              },
              routes: [
                GoRoute(
                  path: Paths.vocabularyChallenge.path,
                  name: Paths.vocabularyChallenge.name,
                  builder: (BuildContext context, GoRouterState state) {
                    final challengeTheme = state.extra as ChallengeThemes?;
                    return MemoryChallengePage(challengeTheme: challengeTheme);
                  },
                  routes: [
                    GoRoute(
                      path: Paths.vocabularyChallengeHistory.path,
                      name: Paths.vocabularyChallengeHistory.name,
                      builder: (BuildContext context, GoRouterState state) {
                        final history =
                            state.extra as List<FlashcardFeedback?>?;
                        return HistoryPage(history: history ?? []);
                      },
                    ),
                    GoRoute(
                      path: Paths.vocabularyChallengeInformation.path,
                      name: Paths.vocabularyChallengeInformation.name,
                      builder: (BuildContext context, GoRouterState state) {
                        final challengeTheme = state.extra as ChallengeThemes?;
                        return InformationPage(challengeTheme: challengeTheme);
                      },
                    ),
                    GoRoute(
                      path: Paths.vocabularyChallengeSettings.path,
                      name: Paths.vocabularyChallengeSettings.name,
                      builder: (BuildContext context, GoRouterState state) {
                        final settings = state.extra as FlashcardsSettings?;
                        return FlashcardsSettingsPage(settings: settings);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
