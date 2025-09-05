import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key, required this.history});

  final List<FlashcardFeedback?> history;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(history[index]?.card.fWord ?? ''),
            Text(history[index]?.isCorrect.toString() ?? ''),
          ],
        );
      },
    );
  }
}
