import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _onClose(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    if (bloc.hasChanges) {
      bloc.add(ApplySettingsEvent());
    }
    context.pop(bloc.hasChanges);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _onClose(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Flashcard Settings')),
        body: SafeArea(
          child:
              BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
                builder: (context, state) {
                  if (state
                      case final ModelHandlerLoaded<FlashcardsSettings> state) {
                    return SettingsView(
                      settings: state.model,
                      onClose: () => _onClose(context),
                    );
                  } else if (state
                      case final ModelHandlerError<FlashcardsSettings> state) {
                    return Center(child: Text(state.failure.message));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
        ),
      ),
    );
  }
}
