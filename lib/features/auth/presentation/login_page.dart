import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, ProjectUser>(
      listener: (context, state) {
        if (state is AuthenticatedUser) {
          context.go('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.read<AuthBloc>().add(
              const AuthSignInAnonymouslyEvent(),
            ),
            child: const Text('Login Anonymously'),
          ),
        ),
      ),
    );
  }
}
