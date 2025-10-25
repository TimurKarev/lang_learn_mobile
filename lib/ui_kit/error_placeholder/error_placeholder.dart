import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart'
    show UiError;
import 'package:lang_learn_mobile/ui_kit/bages/info_bage.dart';

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({super.key, required this.error, this.iconData});

  final UiError error;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            InfoBadge(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              icon: iconData ?? FontAwesomeIcons.triangleExclamation,
              iconSize: 42,
              radius: 48,
            ),
            const SizedBox(height: 32),
            Text(
              error.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              error.description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: error.onRetry,
              child: Text(error.buttonLabel ?? 'Попробовать снова'),
            ),
            const SizedBox(height: 42),
            Text(
              "Если проблема повторяется, обратитесь в службу поддержки",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
