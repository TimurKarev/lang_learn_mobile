import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/common/memory_challenge_view.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';

class MemoryChallengeScreen extends StatelessWidget {
  const MemoryChallengeScreen({super.key, required this.challengeTheme});

  final ChallengeThemes challengeTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Memory Challenge'),
        actions: [
          BlocBuilder<PerformMemoryChallangeBloc, PerformMemoryChallangeState>(
            builder: (context, state) {
              if (state.isChallagePerforming) {
                return BlocBuilder<
                  SettingsBloc,
                  ModelHandlerState<FlashcardsSettings>
                >(
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () async {
                        final result = await context
                            .read<TiliNavigation>()
                            .pushVocabluraySettings(
                              context,
                              settings: switch (state) {
                                ModelHandlerLoaded<FlashcardsSettings> state =>
                                  state.model,
                                _ => null,
                              },
                            );
                        if (result case final FlashcardsSettings settings
                            when (context.mounted)) {
                          context.read<SettingsBloc>().add(
                            ModelHandlerSetModelEvent(settings),
                          );
                          context.read<PerformMemoryChallangeBloc>().add(
                            PerformMemoryChallangeRestartEvent(
                              settings: settings,
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SafeArea(
        child:
            BlocBuilder<
              PerformMemoryChallangeBloc,
              PerformMemoryChallangeState
            >(
              buildWhen: (previous, current) =>
                  (previous is! PerformMemoryChallangeLoaded &&
                  current is PerformMemoryChallangeLoaded),
              builder: (context, state) {
                return switch (state) {
                  PerformMemoryChallangeInitial() ||
                  PerformMemoryChallangeLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  PerformMemoryChallangeLoaded() => const Center(
                    child: MemoryChallengeView(),
                  ),
                };
              },
            ),
      ),
    );
  }
}
