import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_event.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_state.dart';
import 'package:lang_learn_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(
        onboardingRepository: context
            .read<DiLocator>()
            .get<OnboardingRepository>(mock: true),
      )..add(SplashInitialEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashCheckComplete) {
                if (state.isFirst) {
                  context.go('/onboarding');
                } else {
                  context.go('/login');
                }
              }
            },
          ),
          BlocListener<AuthBloc, ProjectUser>(
            listener: (context, state) {
              if (state is AuthenticatedUser) {
                context.go('/home');
              }
            },
          ),
        ],
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 20),
                Text(
                  'Lang Learn Mobile',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
