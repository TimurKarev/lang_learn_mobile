import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/entities/lesson_state.dart';
import 'package:lang_learn_mobile/ui_kit/cards/lesson_card.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class LearningPathSection extends StatelessWidget {
  const LearningPathSection({super.key, this.padding});

  final EdgeInsets? padding;

  static const _listViewHeight = 152.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.learningPath,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: _listViewHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                LessonCard(
                  lessonState: LessonStateCompleted(),
                  padding: const EdgeInsets.only(right: 8),
                  lessonNumber: 1,
                  lessonTitle: l10n.greeting,
                ),
                LessonCard(
                  lessonState: LessonStateInProgress(progress: 0.5),
                  padding: const EdgeInsets.only(right: 8),
                  lessonNumber: 2,
                  lessonTitle: l10n.numbers,
                ),
                LessonCard(
                  lessonState: LessonStateDisabled(),
                  padding: const EdgeInsets.only(right: 8),
                  lessonNumber: 3,
                  lessonTitle: l10n.marketWithGrandma,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
