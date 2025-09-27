import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/ui_kit/cards/progress_card/widgets/info_card.dart';

class ProgressCardInfo extends StatelessWidget {
  const ProgressCardInfo({
    super.key,
    required this.width,
    required this.hour,
    required this.lessons,
    required this.words,
  });

  final double width;
  final int hour;
  final int lessons;
  final int words;

  @override
  Widget build(BuildContext context) {
    final cardWidth = width / 3;
    return Row(
      children: [
        InfoCard(
          width: cardWidth,
          value: hour,
          title: 'Время в обучении',
          measurement: 'ч',
        ),
        InfoCard(width: cardWidth, value: lessons, title: 'Уроков пройдено'),
        InfoCard(width: cardWidth, value: words, title: 'Слов выучено'),
      ],
    );
  }
}
