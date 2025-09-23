import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_event.dart';
import 'package:lang_learn_mobile/features/splash/presentation/bloc/splash_state.dart';
import 'package:lang_learn_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lang_learn_mobile/features/splash/presentation/splash_screen.dart';

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
            listener: (context, state) async {
              if (state is SplashCheckComplete) {
                await Future.delayed(const Duration(seconds: 1));
                if (!context.mounted) return;
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
        child: const SplashScreen(),
      ),
    );
  }
}
