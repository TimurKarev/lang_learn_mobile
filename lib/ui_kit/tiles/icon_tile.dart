import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.disabled = false,
  });

  final IconData icon;
  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: disabled ? null : onTap,
      leading: Icon(icon, color: foregroundColor),
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: disabled ? Icon(Icons.lock, color: foregroundColor) : null,
      tileColor: backgroundColor,
    );
  }
}
