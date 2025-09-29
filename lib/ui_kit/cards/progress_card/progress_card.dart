import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/ui_kit/bages/info_bage.dart';
import 'package:lang_learn_mobile/ui_kit/cards/progress_card/widgets/progress_card_info.dart'
    show ProgressCardInfo;
import 'package:lang_learn_mobile/ui_kit/progress/title_progress.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ваш прогресс",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  InfoBadge(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    icon: FontAwesomeIcons.chartBar,
                    iconSize: 18,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ProgressCardInfo(
                  width: MediaQuery.of(context).size.width - 64 - 32,
                  hour: 12,
                  lessons: 12,
                  words: 12,
                ),
              ),
              Divider(),
              TitleProgress(value: 0.68, title: 'Прогресс курса'),
            ],
          ),
        ),
      ),
    );
  }
}
