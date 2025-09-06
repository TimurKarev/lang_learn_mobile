import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Settings')),
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
          builder: (context, state) {
            if (state case final ModelHandlerLoaded<FlashcardsSettings> state) {
              return SettingsView(settings: state.model);
            } else if (state
                case final ModelHandlerError<FlashcardsSettings> state) {
              return Center(child: Text(state.failure.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
