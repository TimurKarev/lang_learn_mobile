import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

extension ChallengeThemesExtension on ChallengeThemes {
  String localizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      ChallengeThemes.animals => l10n.themeAnimals,
      ChallengeThemes.basic_qualities => l10n.themeBasicQualities,
      ChallengeThemes.biological_verbs => l10n.themeBiologicalVerbs,
      ChallengeThemes.body_parts => l10n.themeBodyParts,
      ChallengeThemes.city => l10n.themeCity,
      ChallengeThemes.clothes => l10n.themeClothes,
      ChallengeThemes.colors => l10n.themeColors,
      ChallengeThemes.consumption_verbs => l10n.themeConsumptionVerbs,
      ChallengeThemes.food => l10n.themeFood,
      ChallengeThemes.functional => l10n.themeFunctional,
      ChallengeThemes.furniture => l10n.themeFurniture,
      ChallengeThemes.head => l10n.themeHead,
      ChallengeThemes.household => l10n.themeHousehold,
      ChallengeThemes.interaction_verbs => l10n.themeInteractionVerbs,
      ChallengeThemes.mind_verbs => l10n.themeMindVerbs,
      ChallengeThemes.movement_verbs => l10n.themeMovementVerbs,
      ChallengeThemes.nature => l10n.themeNature,
      ChallengeThemes.numbers => l10n.numbers,
      ChallengeThemes.people => l10n.themePeople,
      ChallengeThemes.professions => l10n.themeProfessions,
      ChallengeThemes.pronouns => l10n.themePronouns,
      ChallengeThemes.questions => l10n.themeQuestions,
      ChallengeThemes.sizes => l10n.themeSizes,
      ChallengeThemes.tools => l10n.themeTools,
      ChallengeThemes.vehicles => l10n.themeVehicles,
      ChallengeThemes.unknown => l10n.themeUnknown,
    };
  }
}
