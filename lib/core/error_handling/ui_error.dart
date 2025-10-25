class UiError {
  const UiError({
    required this.title,
    required this.displayType,
    required this.description,
    this.onRetry,
    this.buttonLabel,
  });

  final ErrorDisplayType displayType;
  final String title;
  final String description;
  final void Function()? onRetry;
  final String? buttonLabel;

  UiError copyWith({
    ErrorDisplayType? displayType,
    String? title,
    String? description,
    void Function()? onRetry,
    String? buttonLabel,
  }) {
    return UiError(
      displayType: displayType ?? this.displayType,
      title: title ?? this.title,
      description: description ?? this.description,
      onRetry: onRetry ?? this.onRetry,
      buttonLabel: buttonLabel ?? this.buttonLabel,
    );
  }
}

enum ErrorDisplayType { toast, screen, internal, unknown }
