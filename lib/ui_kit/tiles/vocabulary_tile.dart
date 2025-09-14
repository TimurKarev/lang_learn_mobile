import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

class VocabularyTile extends StatelessWidget {
  const VocabularyTile({super.key, required this.memoryCard});

  final Flashcard memoryCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              memoryCard.fWord.word,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 32),
          Text(
            memoryCard.sWord.word,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8),
          Text(
            '/${memoryCard.sWord.transcript}/',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
