import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              child: const Text('LogOut'),
            ),

            BlocBuilder<AuthBloc, ProjectUser>(
              builder: (context, state) {
                return Text(switch (state) {
                  AuthenticatedUser() => 'Authenticated',
                  UnauthenticatedUser() => 'Unauthenticated',
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Onboarding'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
