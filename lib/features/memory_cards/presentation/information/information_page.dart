import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/bloc/information/information_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/information/information_screen.dart';
import 'package:lang_learn_mobile/ui_kit/common_screens/error_screen.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key, required this.challengeTheme});

  final ChallengeThemes? challengeTheme;

  @override
  Widget build(BuildContext context) {
    if (challengeTheme == null) {
      return const ErrorScreen(
        title: 'Challenge theme not found',
        message: 'Challenge theme not found',
      );
    }

    return BlocProvider(
      create: (context) => InformationBloc(
        repository: context.read<DiLocator>().get<MemoryCardsRepository>(),
      )..add(FetchDataEvent<ChallengeThemes>(params: challengeTheme)),
      child: const InformationScreen(),
    );
  }
}
