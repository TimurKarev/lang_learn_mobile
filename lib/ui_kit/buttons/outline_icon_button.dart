import 'package:flutter/material.dart';

class OutlineIconButton extends StatelessWidget {
  const OutlineIconButton({
    required this.icon,
    this.foregroundColor,
    this.outlineColor,
    this.backgroundColor,
    this.onPressed,
    this.size = 48.0,
    this.borderWidth = 2.0,
    super.key,
  });

  final IconData icon;
  final Color? foregroundColor;
  final Color? outlineColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final mainColor = foregroundColor ?? Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: const CircleBorder(),
          side: BorderSide(
            color: outlineColor ?? mainColor,
            width: borderWidth,
          ),
          padding: EdgeInsets.zero,
        ),
        icon: Icon(icon, color: foregroundColor),
      ),
    );
  }
}
