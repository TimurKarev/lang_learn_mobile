import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

class VocabularyTile extends StatelessWidget {
  const VocabularyTile({
    super.key,
    required this.memoryCard,
    this.isFirst = false,
    this.isLast = false,
  });

  final Flashcard memoryCard;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: isFirst ? Radius.circular(12) : Radius.circular(0),
              topRight: isFirst ? Radius.circular(12) : Radius.circular(0),
              bottomLeft: isLast ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isLast ? Radius.circular(12) : Radius.circular(0),
            ),
          ),
          tileColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          title: Text(
            memoryCard.fWord.word,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    '${memoryCard.sWord.word} [${memoryCard.sWord.transcript}]',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isFirst) Divider(thickness: .5, height: 1),
      ],
    );

    // Row(
    //   children: [
    //     Flexible(
    //       child: Text(
    //         memoryCard.fWord.word,
    //         style: Theme.of(context).textTheme.bodyLarge,
    //       ),
    //     ),
    //     const SizedBox(width: 32),
    //     Text(
    //       memoryCard.sWord.word,
    //       style: Theme.of(context).textTheme.titleMedium,
    //     ),
    //     const SizedBox(width: 8),
    //     Text(
    //       '/${memoryCard.sWord.transcript}/',
    //       style: Theme.of(context).textTheme.bodyMedium,
    //     ),
    //   ],
    // );
  }
}
