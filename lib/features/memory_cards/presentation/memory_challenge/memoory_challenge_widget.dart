import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengeWidget extends StatelessWidget {
  const MemoryChallengeWidget({required this.isAnswered, super.key, this.card});

  final Flashcard? card;
  final bool isAnswered;

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Flexible(
            flex: 3,
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
          _ButtonPanel(isAnswered: isAnswered, cardId: card.id),
        ],
      ),
    );
  }
}

class _ButtonPanel extends StatelessWidget {
  const _ButtonPanel({required this.isAnswered, required this.cardId});

  final bool isAnswered;
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),

                  onPressed: isAnswered
                      ? () {
                          context.read<PerformMemoryChallangeBloc>().add(
                            PerformMemoryChallangeNextEvent(feedback: false),
                          );
                        }
                      : null,
                  child: const Text('Wrong'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: isAnswered
                      ? () {
                          context.read<PerformMemoryChallangeBloc>().add(
                            PerformMemoryChallangeNextEvent(feedback: true),
                          );
                        }
                      : null,
                  child: const Text('Correct'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            AppRoutes.goToFlashcardHistory(
              context,
              history: context.read<PerformMemoryChallangeBloc>().history,
            );
          },
          child: SizedBox(
            width: double.infinity,
            child: Center(child: const Text('ShowHistory')),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => AppRoutes.goToInformation(
            context,
            challengeId: context.read<PerformMemoryChallangeBloc>().challengeId,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(child: const Text('ShowVocabulary')),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
