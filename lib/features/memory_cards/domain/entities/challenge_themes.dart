// ignore_for_file: constant_identifier_names

enum ChallengeThemes {
  animals,
  basic_qualities,
  biological_verbs,
  body_parts,
  city,
  clothes,
  colors,
  consumption_verbs,
  food,
  functional,
  furniture,
  head,
  household,
  interaction_verbs,
  mind_verbs,
  movement_verbs,
  nature,
  numbers,
  people,
  professions,
  pronouns,
  questions,
  sizes,
  tools,
  vehicles,
  unknown;

  static ChallengeThemes getByName(
    String? name, {
    ChallengeThemes defaultValue = ChallengeThemes.unknown,
  }) {
    final lName = name?.toLowerCase();
    if (lName == null || lName.isEmpty) {
      return defaultValue;
    }

    final index = ChallengeThemes.values.indexWhere(
      (element) => element.name == lName,
    );

    return index == -1 ? defaultValue : ChallengeThemes.values[index];
  }
}
