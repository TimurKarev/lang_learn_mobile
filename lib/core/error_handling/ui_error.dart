class UiError {
  const UiError({
    required this.title,
    required this.displayType,
    required this.description,
    this.onRetry,
  });

  final ErrorDisplayType displayType;
  final String title;
  final String description;
  final void Function()? onRetry;
}

enum ErrorDisplayType { toast, screen, internal, unknown }
