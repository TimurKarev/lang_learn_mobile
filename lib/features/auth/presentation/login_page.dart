import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/buttons/login_with_button.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/password_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TiliTextField(hintText: 'Email'),
              SizedBox(height: 16),
              PasswordTextField(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<AuthBloc>().add(
                  const AuthSignInAnonymouslyEvent(),
                ),
                child: const Text('Login Anonymously'),
              ),
              LoginWithButton(
                variant: LoginWithButtonVariant.google,
                onPressed: () {},
              ),
              LoginWithButton(
                variant: LoginWithButtonVariant.facebook,
                onPressed: () {},
              ),
              if (Platform.isIOS)
                LoginWithButton(
                  variant: LoginWithButtonVariant.apple,
                  onPressed: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}
