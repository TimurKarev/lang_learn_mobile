import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';
import 'package:lang_learn_mobile/ui_kit/buttons/outline_icon_button.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/add_hint_dialog.dart';

class MemoryCardAnswerBody extends StatelessWidget {
  const MemoryCardAnswerBody({
    super.key,
    required this.question,
    required this.answer,
    required this.onPressAudio,
  });

  final Literal question;
  final Literal answer;
  final void Function(String literalId) onPressAudio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Stack(
          children: [
            Column(
              children: [
                Text(
                  answer.lang.displayRussianName,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  answer.word,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        '/${answer.transcript}/',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (answer.hasAudio)
                      IconButton(
                        icon: Icon(
                          Icons.volume_up,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () => onPressAudio(answer.id),
                      ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 16,
              child: OutlineIconButton(
                icon: Icons.lightbulb,
                onPressed: () => showHintDialog(context),
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),

        Divider(
          thickness: 1,
          height: 64,
          indent: 32,
          endIndent: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(
          question.lang.displayRussianName,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          question.word,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  '/${question.transcript}/',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              if (question.hasAudio)
                IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () => onPressAudio(question.id),
                ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
