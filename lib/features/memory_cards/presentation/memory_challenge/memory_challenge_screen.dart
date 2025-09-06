import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/common/memory_challenge_view.dart';

class MemoryChallengeScreen extends StatelessWidget {
  const MemoryChallengeScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Challenge'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              AppRoutes.goToSettings(
                context,
                settings: FlashcardsSettings.initial(),
              );
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
                  PerformMemoryChallangeInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  PerformMemoryChallangeLoaded() => const Center(
                    child: MemoryChallengeView(),
                  ),
                  PerformMemoryChallangeError(failure: final failure) => Center(
                    child: Text(failure.message),
                  ),
                };
              },
            ),
      ),
    );
  }
}
