import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/core/entities/lesson_state.dart';
import 'package:lang_learn_mobile/ui_kit/bages/info_bage.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lessonState,
    this.padding,
    required this.lessonNumber,
    required this.lessonTitle,
  });

  final LessonState lessonState;
  final EdgeInsets? padding;
  final int lessonNumber;
  final String lessonTitle;

  Color _getBackgroundColor(BuildContext context) => switch (lessonState) {
    LessonStateDisabled() => Theme.of(
      context,
    ).colorScheme.surfaceContainerLowest,
    LessonStateInProgress() => Theme.of(context).colorScheme.primaryContainer,
    LessonStateCompleted() => Theme.of(context).colorScheme.tertiaryContainer,
  };

  Color _getBorderColor(BuildContext context) => switch (lessonState) {
    LessonStateDisabled() => Theme.of(context).colorScheme.outlineVariant,
    LessonStateInProgress() => Theme.of(context).colorScheme.primary,
    LessonStateCompleted() => Theme.of(context).colorScheme.onTertiaryContainer,
  };

  Color _getBageBackroundColor(BuildContext context) => switch (lessonState) {
    LessonStateDisabled() => Theme.of(context).colorScheme.surfaceDim,
    LessonStateInProgress() => Theme.of(context).colorScheme.primary,
    LessonStateCompleted() => Theme.of(context).colorScheme.tertiary,
  };

  Color _getBadgeForegroundColor(BuildContext context) => switch (lessonState) {
    LessonStateDisabled() => Theme.of(context).colorScheme.outline,
    LessonStateInProgress() => Theme.of(context).colorScheme.surfaceContainer,
    LessonStateCompleted() => Theme.of(context).colorScheme.onTertiary,
  };

  IconData _getBadgeIcon(BuildContext context) => switch (lessonState) {
    LessonStateDisabled() => FontAwesomeIcons.lock,
    LessonStateInProgress() => Icons.play_arrow,
    LessonStateCompleted() => Icons.check,
  };

  String get _statusText => switch (lessonState) {
    LessonStateDisabled() => 'Закрыт',
    LessonStateInProgress() => 'Текущий',
    LessonStateCompleted() => 'Завершен',
  };

  double get _value => switch (lessonState) {
    LessonStateDisabled() => 0,
    LessonStateInProgress(progress: final progress) => progress,
    LessonStateCompleted() => 1,
  };

  double get _borderWidth => switch (lessonState) {
    LessonStateDisabled() => 1,
    LessonStateInProgress() => 2,
    LessonStateCompleted() => 1,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getBorderColor(context), width: _borderWidth),
      ),
      elevation: 0,
      color: _getBackgroundColor(context),
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoBadge(
              backgroundColor: _getBageBackroundColor(context),
              foregroundColor: _getBadgeForegroundColor(context),
              icon: _getBadgeIcon(context),
              iconSize: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Урок $lessonNumber: $lessonTitle',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                minHeight: 4,
                value: _value,
                color: _getBageBackroundColor(context),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
            Text(
              _statusText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getBageBackroundColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
