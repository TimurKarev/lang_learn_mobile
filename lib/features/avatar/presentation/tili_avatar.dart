import 'package:flutter/material.dart';

class TiliAvatar extends StatelessWidget {
  const TiliAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      radius: 24,
      child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
