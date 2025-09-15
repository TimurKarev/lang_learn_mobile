import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/bloc/card_list/card_list_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/settings/bloc/settings_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class CardsDashboardScreen extends StatelessWidget {
  const CardsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Cards'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          BlocBuilder<SettingsBloc, ModelHandlerState<FlashcardsSettings>>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  AppRoutes.goToSettings(context);
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CardListBloc, FetchState<List<MemoryCardsPreview>>>(
        builder: (context, state) {
          return switch (state) {
            FetchInitial() => const Center(child: Text('Initial state')),
            FetchLoading<List<MemoryCardsPreview>>() => const Center(
              child: CircularProgressIndicator(),
            ),
            FetchLoaded<List<MemoryCardsPreview>>(data: final data) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Chalanges",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8.0),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final card = data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: MemoryCardTile(
                            title: card.title,
                            description: card.description,
                            onTap: () => AppRoutes.goToChallenge(
                              context,
                              challengeTheme: card.theme,
                            ),
                            onInfoTap: () => AppRoutes.goToInformation(
                              context,
                              challengeTheme: card.theme,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            FetchError<List<MemoryCardsPreview>>(failure: final failure) =>
              Center(child: Text(failure.message)),
          };
        },
      ),
    );
  }
}
