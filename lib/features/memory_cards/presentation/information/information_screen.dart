import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/bloc/information/information_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/tiles/vocabulary_tile.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: BlocBuilder<InformationBloc, FetchState<Vocabulary>>(
          builder: (context, state) {
            return switch (state) {
              FetchInitial() => const Center(child: Text('Initial state')),
              FetchLoading<Vocabulary>() => const Center(
                child: CircularProgressIndicator(),
              ),
              FetchLoaded<Vocabulary>(data: final data) => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16,
                ),
                itemCount: data.memoryCards.length,
                itemBuilder: (context, index) {
                  final card = data.memoryCards[index];
                  return VocabularyTile(memoryCard: card);
                },
              ),
              FetchError<Vocabulary>(failure: final failure) => Center(
                child: Text(failure.message),
              ),
            };
          },
        ),
      ),
    );
  }
}
