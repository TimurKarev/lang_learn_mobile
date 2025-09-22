import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/buttons/login_with_button.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/password_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart';
import 'package:lang_learn_mobile/core/theme/tili_palette.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, ProjectUser>(
      listener: (context, state) {
        if (state is AuthenticatedUser) {
          context.go('/home');
        }
      },
      child: Scaffold(
        backgroundColor: TiliPalette.offWhiteBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue learning',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 40),
                  Text('Email', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  TiliTextField(hintText: 'Enter your email'),
                  const SizedBox(height: 20),
                  Text('Password', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  const PasswordTextField(),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: TiliPalette.deepOrangeAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TiliPalette.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (Platform.isIOS)
                    LoginWithButton(
                      variant: LoginWithButtonVariant.apple,
                      onPressed: () {},
                    ),
                  const SizedBox(height: 16),
                  LoginWithButton(
                    variant: LoginWithButtonVariant.google,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  LoginWithButton(
                    variant: LoginWithButtonVariant.facebook,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
