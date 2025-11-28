import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challange_button_panel.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_page.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengeWidget extends StatelessWidget {
  const MemoryChallengeWidget({required this.isAnswered, super.key, this.card});

  final Flashcard? card;
  final bool isAnswered;

  // static ButtonStyle _buttonStyle(BuildContext context, [bool info = false]) =>
  //     IconButton.styleFrom(
  //       iconSize: 32,
  //       minimumSize: const Size(64, 64),
  //       foregroundColor: info
  //           ? Theme.of(context).colorScheme.tertiary
  //           : Theme.of(context).colorScheme.outline,
  //       side: BorderSide(
  //         color: info
  //             ? Theme.of(context).colorScheme.tertiary
  //             : Theme.of(context).colorScheme.outline,
  //         width: 2,
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    final card = this.card;
    if (card == null) {
      return GestureDetector(
        child: ErrorPage(
          error: UiError(
            title: 'Unhandled state',
            description: 'Card is null',
            displayType: ErrorDisplayType.screen,
            buttonLabel: 'Вернуться назад',
            onRetry: () => context.pop(),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MemoryCardWidget(
              alignment: Alignment.topCenter,
              onPressAudio: (String literalId) {
                context.read<PerformMemoryChallangeBloc>().add(
                  PerformMemoryChallangePlayAudioEvent(literalId),
                );
              },
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
          MemoryChallangeButtonPanel(isAnswered: isAnswered, cardId: card.id),
        ],
      ),
    );
  }
}
