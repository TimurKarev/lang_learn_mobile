import 'package:flutter/material.dart';

class TiliSwitchListTile extends StatelessWidget {
  const TiliSwitchListTile({
    super.key,
    required this.onChanged,
    required this.value,
    required this.title,
  });

  final void Function(bool) onChanged;
  final bool value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      child: SwitchListTile(
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
