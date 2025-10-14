class Failure {
  const Failure({
    required this.message,
    required this.technicalMessage,
    required this.type,
    required this.stackTrace,
    this.error,
    this.code,
  });

  final String message;
  final String technicalMessage;
  final FailureType type;
  final StackTrace stackTrace;
  final Object? error;
  final int? code;
}

enum FailureType { internalParamError, authFailed, supabaseError }
