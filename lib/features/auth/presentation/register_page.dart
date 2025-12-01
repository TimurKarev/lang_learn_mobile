import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/register_bloc.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/password_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/toasts/tili_toast.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authRepository: context.read<DiLocator>().get<AuthRepository>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.success) {
          // Navigate to home or show success message and go to login
          // Assuming successful registration logs the user in automatically
          // and AuthBloc will handle the auth state change.
          // However, we might need to wait for AuthBloc to update.
          // For now, let's just pop or go to home if AuthBloc listens to the same repo stream.
          // Since AuthSupabaseRepository emits on authStateChange, AuthBloc should pick it up.
          // So we might not need to do anything if AuthBloc handles navigation.
          // But usually we want to show a success message or navigate explicitly if needed.
          // Let's rely on AuthBloc listener in the main layout or similar.
          // But wait, RegisterPage is likely pushed on top of LoginPage or replaces it.
          // If AuthBloc is global, it will trigger navigation.
        } else if (state.status == RegisterStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TiliToast(
                message: state.errorMessage ?? l10n.registrationFailed,
                type: ToastType.error,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.createAccount)),
        backgroundColor: theme.colorScheme.surface,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Full Name
                Text(l10n.fullName, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    return TiliTextField(
                      hintText: l10n.yourName,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(
                          RegisterNameChanged(value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Email Address
                Text(l10n.email, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return TiliTextField(
                      hintText: l10n.emailPlaceholder,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(
                          RegisterEmailChanged(value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Password
                Text(l10n.password, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    return PasswordTextField(
                      enabled: true,
                      hintText: l10n.createStrongPassword,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(
                          RegisterPasswordChanged(value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password
                Text(l10n.confirmPassword, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.confirmPassword != current.confirmPassword,
                  builder: (context, state) {
                    return PasswordTextField(
                      enabled: true,
                      hintText: l10n.confirmYourPassword,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(
                          RegisterConfirmPasswordChanged(value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Terms
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.termsAccepted != current.termsAccepted,
                  builder: (context, state) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: state.termsAccepted,
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(
                                RegisterTermsChanged(value ?? false),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: l10n.iAgreeTo,
                              style: theme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: l10n.termsOfUse,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: l10n.and),
                                TextSpan(
                                  text: l10n.privacyPolicy,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Create Account Button
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.canSubmit
                          ? () {
                              context.read<RegisterBloc>().add(
                                const RegisterSubmitted(),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFE87A54,
                        ), // Orange color from image
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.status == RegisterStatus.loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              l10n.createAccount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.alreadyHaveAccount),
                    GestureDetector(
                      onTap: () {
                        context.pop(); // Go back to Login
                      },
                      child: Text(
                        l10n.signIn,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
