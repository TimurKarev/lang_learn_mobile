import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/features/avatar/presentation/tili_avatar.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/cards_dashboard/bloc/card_list/card_list_bloc.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_placeholder.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class CardsDashboardScreen extends StatelessWidget {
  const CardsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 48 - 16) / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Cards'),
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left, size: 36),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 24.0), child: TiliAvatar()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<CardListBloc, FetchState<List<MemoryCardsPreview>>>(
          builder: (context, state) {
            return switch (state) {
              FetchInitial() => const Center(child: Text('Initial state')),
              FetchLoading<List<MemoryCardsPreview>>() => const Center(
                child: CircularProgressIndicator(),
              ),
              FetchLoaded<List<MemoryCardsPreview>>(data: final data) => Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (int i = 0; i < data.length; i++)
                    ChallangeCard(
                      width: width,
                      title: data[i].title,
                      theme: data[i].theme,
                      onTap: () => context.read<TiliNavigation>().goToChallenge(
                        context,
                        challengeTheme: data[i].theme,
                      ),
                    ),
                ],
              ),
              FetchError<List<MemoryCardsPreview>>(error: final error) =>
                ErrorPlaceholder(error: error),
            };
          },
        ),
      ),
    );
  }
}
