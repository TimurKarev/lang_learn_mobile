import 'package:flutter/material.dart';

class TitleProgress extends StatelessWidget {
  const TitleProgress({
    super.key,
    required this.value,
    required this.title,
    this.foregroundColor,
    this.backgroundColor,
  });

  final double value;
  final String title;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '${(value * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: foregroundColor ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          color: foregroundColor,
        ),
      ],
    );
  }
}
