import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/bloc/fetch_bloc/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/use_case/fetch_memory_cards_for_challenge.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_card.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/fetch_memory_challenge/memory_challenge_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_screen.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';

class MemoryChallengePage extends StatelessWidget {
  const MemoryChallengePage({super.key, required this.challengeId});

  final String? challengeId;

  @override
  Widget build(BuildContext context) {
    if (challengeId case final String id) {
      return BlocProvider(
        create: (context) => FetchMemoryChallengeBloc(
          FetchMemoryCardsForChallenge(
            context.read<DiLocator>().get<MemoryCardsRepository>(mock: true),
            id,
          ),
        )..add(FetchDataEvent<List<MemoryCard>>()),
        child: const MemoryChallengeScreen(),
      );
    } else {
      return const ErrorScreen(
        title: 'Error',
        message: 'Challenge ID is required',
      );
    }
  }
}
