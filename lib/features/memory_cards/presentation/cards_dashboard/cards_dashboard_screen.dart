import 'package:flutter/material.dart';

class CardsDashboardScreen extends StatelessWidget {
  const CardsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Cards'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Placeholder(),
    );
  }
}
