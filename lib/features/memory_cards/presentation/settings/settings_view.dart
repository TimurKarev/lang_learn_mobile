import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.settings});

  final FlashcardsSettings settings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Shuffle Cards'),
            value: settings.shufleCards,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                ShuffleCardsChangesSettingsEvent(value),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Repeat Wrong Answers'),
            value: settings.repeatWrong,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                RepeatWrongChangesSettingsEvent(value),
              );
            },
          ),
          const SizedBox(height: 20),
          Text('Ask Language', style: Theme.of(context).textTheme.titleMedium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: DropdownButton<Languages>(
                value: settings.askLanguage,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(
                      AskLanguageChangesSettingsEvent(value),
                    );
                  }
                },
                items: Languages.values.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language.name),
                  );
                }).toList(),
              ),
            ),
          ),
          const Spacer(),
          BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
            builder: (context, state) {
              final bloc = context.read<SettingsBloc>();
              return ElevatedButton(
                onPressed: bloc.hasChanges
                    ? () {
                        if (state
                            case final ModelHandlerLoaded<FlashcardsSettings>
                                loadedState) {
                          context.pop(loadedState.model);
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save'),
              );
            },
          ),
        ],
      ),
    );
  }
}
