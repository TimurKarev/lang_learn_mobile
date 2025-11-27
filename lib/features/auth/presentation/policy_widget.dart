import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Text.rich(
      TextSpan(
        text: l10n.byContinuing,
        style: theme.textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                context.go('/terms-of-use');
              },
              child: Text(
                l10n.termsOfUse,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          TextSpan(
            text: l10n.and,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                context.go('/privacy-policy');
              },
              child: Text(
                l10n.privacyPolicy,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
