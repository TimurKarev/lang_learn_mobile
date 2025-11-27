import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/flashcards_settings_view.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_placeholder.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

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
            bloc.add(ModelHandlerFetchEvent());
          }
          return bloc;
        },
        child: BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.flashcardSettings),
                leading: GestureDetector(
                  child: Icon(Icons.chevron_left, size: 36),
                  onTap: () => _onClose(context),
                ),
              ),
              body: SafeArea(
                child: Builder(
                  builder: (context) {
                    if (state
                        case final ModelHandlerLoaded<FlashcardsSettings>
                            state) {
                      return FlashcardsSettingsView(
                        settings: state.model,
                        onClose: () => _onClose(context),
                        hasChanges: context.read<SettingsBloc>().hasChanges,
                      );
                    } else if (state
                        case final ModelHandlerError<FlashcardsSettings>
                            state) {
                      return ErrorPlaceholder(error: state.uiError);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
