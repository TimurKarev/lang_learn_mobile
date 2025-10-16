import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challange_button_panel.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengeWidget extends StatelessWidget {
  const MemoryChallengeWidget({required this.isAnswered, super.key, this.card});

  final Flashcard? card;
  final bool isAnswered;

  static ButtonStyle _buttonStyle(BuildContext context) => IconButton.styleFrom(
    iconSize: 32,
    minimumSize: const Size(64, 64),
    foregroundColor: Theme.of(context).colorScheme.outline,
    side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    final card = this.card;
    if (card == null) {
      return GestureDetector(
        child: ErrorScreen(title: 'Unhandled state', message: 'Card is null'),
        onTap: () {
          context.pop();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: MemoryCardWidget(
              key: ValueKey(card.id),
              padding: const EdgeInsets.only(top: 8.0),
              card: card,
              onCardFlipped: () {
                context.read<PerformMemoryChallangeBloc>().add(
                  PerformMemoryChallangeAnswerEvent(card),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: _buttonStyle(context),
                onPressed: () {
                  context.read<TiliNavigation>().goToFlashcardHistory(
                    context,
                    history: context.read<PerformMemoryChallangeBloc>().history,
                  );
                },
                icon: const Icon(Icons.history),
              ),
              const SizedBox(width: 16),
              IconButton(
                style: _buttonStyle(context),
                onPressed: () =>
                    context.read<TiliNavigation>().pushVocabularyInformation(
                      context,
                      challengeTheme: context
                          .read<PerformMemoryChallangeBloc>()
                          .challengeTheme,
                    ),
                icon: const Icon(Icons.info),
              ),
            ],
          ),
          const Spacer(),
          MemoryChallangeButtonPanel(isAnswered: isAnswered, cardId: card.id),
        ],
      ),
    );
  }
}
