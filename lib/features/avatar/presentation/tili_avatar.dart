import 'package:flutter/material.dart';

class TiliAvatar extends StatelessWidget {
  const TiliAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      child: const Icon(Icons.person, color: Colors.black),
    );
  }
}
