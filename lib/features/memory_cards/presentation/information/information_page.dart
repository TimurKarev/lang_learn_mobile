import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/bloc/information/information_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_screen.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InformationBloc(
        repository: context.read<DiLocator>().get<MemoryCardsRepository>(
          mock: true,
        ),
      )..add(FetchDataEvent<String>(params: challengeId)),
      child: const InformationScreen(),
    );
  }
}
