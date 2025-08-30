import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_callange_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';

class MemoryChallengeView extends StatelessWidget {
  const MemoryChallengeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformMemoryChallangeBloc, PerformMemoryChallangeState>(
      buildWhen: (previous, current) =>
          previous is PerformMemoryChallangeLoaded &&
          current is PerformMemoryChallangeLoaded,
      builder: (context, state) {
        if (state is PerformMemoryChallangeChooseCard) {
          return CircularProgressIndicator();
        }
        if (state is PerformMemoryChallangeCardReady) {
          return InkWell(
            child: Text(state.card.front),
            onTap: () {
              context.read<PerformMemoryChallangeBloc>().add(
                PerformMemoryChallangeNextEvent(
                  DualMemoryChallangeFeedback(
                    cardId: state.card.id,
                    isCorrect: true,
                  ),
                ),
              );
            },
          );
        }
        if (state is PerformMemoryChallangeFinished) {
          return const Placeholder();
        }
        return const Placeholder();
      },
    );
  }
}
