import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LoginWithButtonVariant { google, apple, facebook }

class LoginWithButton extends StatelessWidget {
  const LoginWithButton({
    super.key,
    required this.variant,
    this.enabled = true,
    required this.onPressed,
  });

  final LoginWithButtonVariant variant;
  final bool enabled;
  final VoidCallback onPressed;

  String get _text {
    switch (variant) {
      case LoginWithButtonVariant.google:
        return 'Google';
      case LoginWithButtonVariant.apple:
        return 'Apple';
      case LoginWithButtonVariant.facebook:
        return 'Facebook';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        iconColor: switch (variant) {
          LoginWithButtonVariant.google => Theme.of(
            context,
          ).colorScheme.onSurface,
          LoginWithButtonVariant.apple => Theme.of(
            context,
          ).colorScheme.onPrimary,
          LoginWithButtonVariant.facebook => Color(0xFF4267B2),
        },
      ),
      onPressed: enabled ? () => onPressed.call() : null,
      icon: Icon(
        variant == LoginWithButtonVariant.google
            ? FontAwesomeIcons.google
            : variant == LoginWithButtonVariant.apple
            ? FontAwesomeIcons.apple
            : FontAwesomeIcons.facebook,
      ),
      label: Text('Login with $_text'),
    );
  }
}
