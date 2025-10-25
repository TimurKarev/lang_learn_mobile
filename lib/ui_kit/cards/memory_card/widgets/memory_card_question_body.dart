import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/hint/flashcard_hint_widget.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart'
    show SettingsBloc;
import 'package:lang_learn_mobile/ui_kit/buttons/outline_icon_button.dart';

class MemoryCardQuestionBody extends StatefulWidget {
  const MemoryCardQuestionBody({
    super.key,
    required this.question,
    required this.lang,
    required this.transcript,
    required this.stringHint,
    required this.imageHintPath,
  });

  final String question;
  final Languages lang;
  final String transcript;
  final String stringHint;
  final String imageHintPath;

  @override
  State<MemoryCardQuestionBody> createState() => _MemoryCardQuestionBodyState();
}

class _MemoryCardQuestionBodyState extends State<MemoryCardQuestionBody> {
  bool _isHintVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Text(
          widget.lang.displayRussianName,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          widget.question,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (widget.imageHintPath.isNotEmpty || widget.stringHint.isNotEmpty)
          Expanded(
            child:
                BlocBuilder<
                  SettingsBloc,
                  ModelHandlerState<FlashcardsSettings>
                >(
                  builder: (context, state) {
                    if (state
                        case final ModelHandlerLoaded<FlashcardsSettings>
                            loadedState when loadedState.model.isShowHint) {
                      if (_isHintVisible) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FlashcardHintWidget(
                            picturePath: widget.imageHintPath,
                            stringHint: widget.stringHint,
                          ),
                        );
                      } else {
                        return OutlineIconButton(
                          icon: Icons.lightbulb,
                          size: 64,
                          iconSize: 48,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          onPressed: () {
                            setState(() {
                              _isHintVisible = true;
                            });
                          },
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
          ),
      ],
    );
  }
}
