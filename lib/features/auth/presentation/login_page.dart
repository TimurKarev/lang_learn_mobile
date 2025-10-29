import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/auth/presentation/policy_widget.dart';
import 'package:lang_learn_mobile/ui_kit/buttons/login_with_button.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/password_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/toasts/tili_toast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, ProjectUser>(
      listener: (context, state) {
        if (state is AuthenticatedUser) {
          context.go('/home');
        } else if (state case final UnauthenticatedUser unauthenticatedUser
            when unauthenticatedUser.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TiliToast(
                message: unauthenticatedUser.error?.description ?? '',
                type: ToastType.error,
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Войти в приложение',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  Text('Email', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  TiliTextField(hintText: 'Enter your email', enabled: false),
                  const SizedBox(height: 16),
                  Text('Password', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  PasswordTextField(enabled: false),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                      TextButton(onPressed: null, child: Text('Sign Up')),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (Platform.isIOS)
                    LoginWithButton(
                      variant: LoginWithButtonVariant.apple,
                      onPressed: () {},
                      enabled: false,
                    ),
                  const SizedBox(height: 16),
                  LoginWithButton(
                    variant: LoginWithButtonVariant.google,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignInWithGoogleEvent());
                    },
                  ),
                  const SizedBox(height: 16),
                  LoginWithButton(
                    variant: LoginWithButtonVariant.facebook,
                    onPressed: () {},
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  PolicyWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
