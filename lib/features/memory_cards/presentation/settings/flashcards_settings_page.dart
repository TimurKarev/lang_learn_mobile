import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/flashcards_settings_view.dart';

class FlashcardsSettingsPage extends StatelessWidget {
  const FlashcardsSettingsPage({super.key, required this.settings});

  final FlashcardsSettings? settings;

  void _onClose(BuildContext context) {
    final bloc = context.read<SettingsBloc?>();
    if (bloc?.hasChanges ?? false) {
      context.pop(switch (bloc?.state) {
        ModelHandlerLoaded<FlashcardsSettings> state => state.model,
        _ => null,
      });
    } else {
      context.pop();
    }
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
      child: BlocProvider(
        create: (context) {
          final bloc = SettingsBloc(
            context.read<DiLocator>().get<FlashcardSettingsRepository>(),
          );
          if (settings case final FlashcardsSettings settings) {
            bloc.add(ModelHandlerSetModelEvent(settings));
          } else {
            bloc.add(
              ModelHandlerFetchEvent(params: FlashcardsSettings.initial()),
            );
          }
          return bloc;
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Flashcard Settings')),
          body: SafeArea(
            child:
                BlocBuilder<
                  SettingsBloc,
                  ModelHandlerState<FlashcardsSettings>
                >(
                  builder: (context, state) {
                    if (state
                        case final ModelHandlerLoaded<FlashcardsSettings>
                            state) {
                      return FlashcardsSettingsView(
                        settings: state.model,
                        onClose: () => _onClose(context),
                      );
                    } else if (state
                        case final ModelHandlerError<FlashcardsSettings>
                            state) {
                      return Center(child: Text(state.failure.message));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
          ),
        ),
      ),
    );
  }
}
