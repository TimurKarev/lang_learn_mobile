sealed class LessonState {
  const LessonState();
}

class LessonStateInProgress extends LessonState {
  const LessonStateInProgress({required this.progress});

  final double progress;
}

class LessonStateCompleted extends LessonState {
  const LessonStateCompleted();
}

class LessonStateDisabled extends LessonState {
  const LessonStateDisabled();
}
