import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({super.key});

  // Style definition from Figma
  static final BoxDecoration _cardDecoration = BoxDecoration(
    color: const Color(0xFF4C7F8B),
    borderRadius: BorderRadius.circular(12),
  );

  // Padding definition from Figma
  static final EdgeInsets _cardPadding = EdgeInsets.all(17);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration,
      padding: _cardPadding,
      width: 400,
      height: 200,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First section: 32x32px with 1 child element
          _FirstSection(),

          // Second section: 51x40px with 2 child elements
          _SecondSection(),

          // Third section: 115x24px with 2 child elements
          _ThirdSection(),
        ],
      ),
    );
  }
}

// First section with icon or small element
class _FirstSection extends StatelessWidget {
  const _FirstSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, color: Color(0xFF4C7F8B), size: 20),
    );
  }
}

// Second section with two child elements
class _SecondSection extends StatelessWidget {
  const _SecondSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Level',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '5',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Third section with two child elements
class _ThirdSection extends StatelessWidget {
  const _ThirdSection();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'challange finished',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
