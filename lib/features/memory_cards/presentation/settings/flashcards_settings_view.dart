import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/custom/dual_radio_list.dart';
import 'package:lang_learn_mobile/ui_kit/tiles/tili_switch_list_tile.dart';

// Менять надпись на кнопке в зависимости от статуса
class FlashcardsSettingsView extends StatelessWidget {
  const FlashcardsSettingsView({
    super.key,
    required this.settings,
    required this.onClose,
    required this.hasChanges,
  });

  final FlashcardsSettings settings;
  final Function() onClose;
  final bool hasChanges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Настройки',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TiliSwitchListTile(
            title: 'Перемешивать карточки',
            value: settings.isShufleCards,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                ShuffleCardsChangesSettingsEvent(value),
              );
            },
          ),
          const SizedBox(height: 16),
          TiliSwitchListTile(
            title: 'Повторять неправильные ответы',
            value: settings.isRepeatWrong,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                RepeatWrongChangesSettingsEvent(value),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Язык вопроса',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DualRadioList<Languages>(
            value1: Languages.ru,
            value2: Languages.ky,
            labelBuilder: (value) => value.displayRussianName,
            isValue1: settings.askLanguage == Languages.ru,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                AskLanguageChangesSettingsEvent(value),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: onClose,
                child: Text(hasChanges ? 'Применить' : 'Закрыть'),
              );
            },
          ),
        ],
      ),
    );
  }
}
