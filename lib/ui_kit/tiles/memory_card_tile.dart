import 'package:flutter/material.dart';

class MemoryCardTile extends StatelessWidget {
  const MemoryCardTile({
    required this.title,
    required this.description,
    this.padding = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          elevation: 2,
          child: InkWell(
            onTap: onTap,
            child: ListTile(title: Text(title), subtitle: Text(description)),
          ),
        ),
      ),
    );
  }
}
