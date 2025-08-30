import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/core/bloc/fetch_bloc/fetch_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/fetch_memory_challenge/memory_challenge_bloc.dart';

class MemoryChallengeScreen extends StatelessWidget {
  const MemoryChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Challenge'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<FetchMemoryChallengeBloc, FetchState<List<MemoryCard>>>(
        builder: (context, state) {
          return switch (state) {
            FetchInitial() => const Center(child: Text('Initial state')),
            FetchLoading<List<MemoryCard>>() => const Center(
              child: CircularProgressIndicator(),
            ),
            FetchLoaded<List<MemoryCard>>(data: final data) => const Center(
              child: Text('Placeholder for challenge content'),
            ),
            FetchError<List<MemoryCard>>(failure: final failure) => Center(
              child: Text(failure.message),
            ),
          };
        },
      ),
    );
  }
}
