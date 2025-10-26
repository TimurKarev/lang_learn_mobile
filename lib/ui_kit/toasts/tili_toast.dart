import 'package:flutter/material.dart';

enum ToastType { success, error, info, warning }

class TiliToast extends StatelessWidget {
  final String message;
  final ToastType type;
  final VoidCallback? onClose;
  final Duration duration;
  final bool showCloseButton;

  const TiliToast({
    super.key,
    required this.message,
    this.type = ToastType.success,
    this.onClose,
    this.duration = const Duration(seconds: 3),
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color backgroundColor;
    Color iconColor;
    IconData iconData;

    switch (type) {
      case ToastType.success:
        backgroundColor = colorScheme.surface;
        iconColor = colorScheme.tertiary;
        iconData = Icons.check_circle;
        break;
      case ToastType.error:
        backgroundColor = colorScheme.surface;
        iconColor = colorScheme.error;
        iconData = Icons.error;
        break;
      case ToastType.info:
        backgroundColor = colorScheme.surface;
        iconColor = colorScheme.primary;
        iconData = Icons.info;
        break;
      case ToastType.warning:
        backgroundColor = colorScheme.surface;
        iconColor = colorScheme.secondary;
        iconData = Icons.warning;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          if (showCloseButton && onClose != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
