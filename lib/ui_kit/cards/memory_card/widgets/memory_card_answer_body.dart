import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/constants/ui_constants.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';
import 'package:lang_learn_mobile/core/utils/string_extension.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/add_hint/add_hint_dialog.dart';

class MemoryCardAnswerBody extends StatelessWidget {
  const MemoryCardAnswerBody({
    super.key,
    required this.question,
    required this.answer,
    required this.onPressAudio,
    required this.literaId,
  });

  final Literal question;
  final Literal answer;
  final void Function(String literalId) onPressAudio;
  final String literaId;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: UIConstants.maxCardHeight),
      child: Stack(
        children: [
          Column(
            children: [
              //const Spacer(),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          answer.lang.displayRussianName,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          answer.word.capitalizeFirst(),
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
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
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
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
                  ],
                ),
              ),

              Divider(
                thickness: 1,
                height: 64,
                indent: 32,
                endIndent: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      question.lang.displayRussianName,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.word.capitalizeFirst(),
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
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
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
                  ],
                ),
              ),

              //const Spacer(),
            ],
          ),

          Positioned(
            top: 16,
            right: 16,
            child: Stack(
              children: [
                Positioned(
                  bottom: 6,
                  right: 0,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.lightbulb_outline_rounded),
                  iconSize: 42,
                  onPressed: () =>
                      showAddHintDialog(context, literaId: literaId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
