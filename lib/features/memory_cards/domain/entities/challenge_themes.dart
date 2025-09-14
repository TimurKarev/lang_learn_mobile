enum ChallengeThemes {
  number,
  household,
  unknown;

  static ChallengeThemes getByName(
    String name, {
    ChallengeThemes defaultValue = ChallengeThemes.unknown,
  }) {
    final index = ChallengeThemes.values.indexWhere(
      (element) => element.name == name,
    );

    return index == -1 ? defaultValue : ChallengeThemes.values[index];
  }
}
