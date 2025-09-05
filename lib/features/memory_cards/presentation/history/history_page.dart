import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_feedback.dart';
import 'package:lang_learn_mobile/features/memory_cards/presentation/memory_challenge/history_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.history});

  final List<FlashcardFeedback?> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: SafeArea(child: HistoryView(history: history)),
    );
  }
}
