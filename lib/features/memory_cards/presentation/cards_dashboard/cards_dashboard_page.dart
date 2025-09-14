import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'bloc/card_list/card_list_bloc.dart';
import 'cards_dashboard_screen.dart';

class CardsDashboardPage extends StatelessWidget {
  const CardsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardListBloc(
            repository: context.read<DiLocator>().get<MemoryCardsRepository>(),
          )..add(FetchDataEvent<List<MemoryCardsPreview>>()),
        ),
      ],
      child: const CardsDashboardScreen(),
    );
  }
}
