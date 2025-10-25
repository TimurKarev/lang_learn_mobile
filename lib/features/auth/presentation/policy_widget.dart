import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        text: 'By continuing I accept ',
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
                'Terms of Use',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          TextSpan(
            text: ' and ',
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
                'Privacy Policy',
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
