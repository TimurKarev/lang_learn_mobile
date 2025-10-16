import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';

class MemoryCardQuestionBody extends StatelessWidget {
  const MemoryCardQuestionBody({
    super.key,
    required this.question,
    required this.lang,
    required this.transcript,
  });

  final String question;
  final Languages lang;
  final String transcript;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Text(
          lang.displayRussianName,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          question,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
