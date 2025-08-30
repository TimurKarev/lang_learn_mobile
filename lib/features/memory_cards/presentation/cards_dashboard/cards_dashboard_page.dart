import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/memory_cards_repository_impl.dart';
import 'bloc/memory_cards_bloc.dart';
import 'cards_dashboard_screen.dart';

class CardsDashboardPage extends StatelessWidget {
  const CardsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemoryCardsBloc(repository: MemoryCardsRepositoryImpl()),
      child: const CardsDashboardScreen(),
    );
  }
}
