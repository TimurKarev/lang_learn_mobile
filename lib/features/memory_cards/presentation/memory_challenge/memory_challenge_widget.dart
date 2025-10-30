import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challange_button_panel.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart'
    show SettingsBloc;
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_page.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengeWidget extends StatelessWidget {
  const MemoryChallengeWidget({required this.isAnswered, super.key, this.card});

  final Flashcard? card;
  final bool isAnswered;

  static ButtonStyle _buttonStyle(BuildContext context, [bool info = false]) =>
      IconButton.styleFrom(
        iconSize: 32,
        minimumSize: const Size(64, 64),
        foregroundColor: info
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.outline,
        side: BorderSide(
          color: info
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      );

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
        children: [
          Flexible(
            flex: 4,
            child: MemoryCardWidget(
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
          const SizedBox(height: 24),
          BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
            builder: (context, state) {
              if (state
                  case final ModelHandlerLoaded<FlashcardsSettings> loadedState
                  when loadedState.model.isShowHint) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      style: _buttonStyle(context),
                      onPressed: () {
                        context.read<TiliNavigation>().goToFlashcardHistory(
                          context,
                          history: context
                              .read<PerformMemoryChallangeBloc>()
                              .history,
                        );
                      },
                      icon: const Icon(Icons.history),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      style: _buttonStyle(context, true),
                      onPressed: () => context
                          .read<TiliNavigation>()
                          .pushVocabularyInformation(
                            context,
                            challengeTheme: context
                                .read<PerformMemoryChallangeBloc>()
                                .challengeTheme,
                          ),
                      icon: const Icon(Icons.info),
                    ),
                  ],
                );
              }
              return const SizedBox(height: 64);
            },
          ),
          const Spacer(),
          MemoryChallangeButtonPanel(isAnswered: isAnswered, cardId: card.id),
        ],
      ),
    );
  }
}
