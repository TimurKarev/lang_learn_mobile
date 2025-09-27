import 'package:flutter/material.dart';

class InfoBadge extends StatelessWidget {
  const InfoBadge({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.iconSize,
    this.radius = 18,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? iconSize;
  final double? radius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Icon(icon, color: foregroundColor, size: iconSize),
    );
  }
}
