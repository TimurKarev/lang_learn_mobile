import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Enter Dashboard'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(AuthLogoutEvent()),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
