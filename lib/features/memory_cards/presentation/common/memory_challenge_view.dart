import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/bloc/perform_memory_challange/perform_memory_challange_bloc.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/history_view.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/memory_challenge_widget.dart';

class MemoryChallengeView extends StatelessWidget {
  const MemoryChallengeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformMemoryChallangeBloc, PerformMemoryChallangeState>(
      builder: (context, state) {
        if (state is PerformMemoryChallangeChooseCard) {
          return CircularProgressIndicator();
        }
        if ((state is PerformMemoryChallangeQuestion ||
            state is PerformMemoryChallangeAnswer)) {
          final card = switch (state) {
            PerformMemoryChallangeQuestion() => state.card,
            PerformMemoryChallangeAnswer() => state.card,
            // TODO: Handle other states.
            _ => throw UnimplementedError(),
          };
          final isAnswered = state is PerformMemoryChallangeAnswer;
          return MemoryChallengeWidget(isAnswered: isAnswered, card: card);
        }
        if (state is PerformMemoryChallangeFinished) {
          return HistoryView(history: state.history);
        }
        return const Placeholder();
      },
    );
  }
}
