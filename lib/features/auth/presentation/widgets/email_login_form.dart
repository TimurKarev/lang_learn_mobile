import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/login_with_email_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/password_text_field.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';
import 'package:lang_learn_mobile/ui_kit/toasts/tili_toast.dart';

class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocConsumer<LoginWithEmailBloc, LoginWithEmailState>(
      listener: (context, state) {
        if (state.status == LoginWithEmailStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: TiliToast(
                message: state.errorMessage ?? l10n.error,
                type: ToastType.error,
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.email, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            TiliTextField(
              hintText: l10n.enterEmail,
              onChanged: (value) {
                context.read<LoginWithEmailBloc>().add(
                  LoginEmailChanged(value),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(l10n.password, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            PasswordTextField(
              enabled: state.status != LoginWithEmailStatus.loading,
              onChanged: (value) {
                context.read<LoginWithEmailBloc>().add(
                  LoginPasswordChanged(value),
                );
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement forgot password
                },
                child: Text(l10n.forgotPassword),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: state.canSubmit()
                  ? () {
                      context.read<LoginWithEmailBloc>().add(
                        const LoginSubmitted(),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state.status == LoginWithEmailStatus.loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.login,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ],
        );
      },
    );
  }
}
