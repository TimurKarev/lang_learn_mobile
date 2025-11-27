import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/ui_kit/bages/info_bage.dart';

class ChallangeCard extends StatelessWidget {
  const ChallangeCard({
    required this.title,
    this.padding = EdgeInsets.zero,
    this.onTap,
    required this.width,
    required this.theme,
    this.onDictionaryTap,
    super.key,
  });

  final String title;
  final EdgeInsets padding;
  final ChallengeThemes theme;
  final VoidCallback? onTap;
  final VoidCallback? onDictionaryTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: SizedBox(
          width: width,
          height: 160,
          child: Stack(
            children: [
              if (onDictionaryTap != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onDictionaryTap,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Все слова',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InfoBadge(
                      icon: _iconData,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      radius: 24,
                      iconSize: 18,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData get _iconData {
    switch (theme) {
      case ChallengeThemes.animals:
        return FontAwesomeIcons.paw;
      case ChallengeThemes.basic_qualities:
        return FontAwesomeIcons.star;
      case ChallengeThemes.biological_verbs:
        return FontAwesomeIcons.heartPulse;
      case ChallengeThemes.body_parts:
        return FontAwesomeIcons.user;
      case ChallengeThemes.city:
        return FontAwesomeIcons.city;
      case ChallengeThemes.clothes:
        return FontAwesomeIcons.shirt;
      case ChallengeThemes.colors:
        return FontAwesomeIcons.palette;
      case ChallengeThemes.consumption_verbs:
        return FontAwesomeIcons.utensils;
      case ChallengeThemes.food:
        return FontAwesomeIcons.appleWhole;
      case ChallengeThemes.functional:
        return FontAwesomeIcons.gears;
      case ChallengeThemes.furniture:
        return FontAwesomeIcons.couch;
      case ChallengeThemes.head:
        return FontAwesomeIcons.circleUser;
      case ChallengeThemes.household:
        return FontAwesomeIcons.house;
      case ChallengeThemes.interaction_verbs:
        return FontAwesomeIcons.handshake;
      case ChallengeThemes.mind_verbs:
        return FontAwesomeIcons.brain;
      case ChallengeThemes.movement_verbs:
        return FontAwesomeIcons.personRunning;
      case ChallengeThemes.nature:
        return FontAwesomeIcons.leaf;
      case ChallengeThemes.numbers:
        return FontAwesomeIcons.seven;
      case ChallengeThemes.people:
        return FontAwesomeIcons.users;
      case ChallengeThemes.professions:
        return FontAwesomeIcons.briefcase;
      case ChallengeThemes.pronouns:
        return FontAwesomeIcons.user;
      case ChallengeThemes.questions:
        return FontAwesomeIcons.question;
      case ChallengeThemes.sizes:
        return FontAwesomeIcons.maximize;
      case ChallengeThemes.tools:
        return FontAwesomeIcons.wrench;
      case ChallengeThemes.vehicles:
        return FontAwesomeIcons.car;
      case ChallengeThemes.unknown:
        return FontAwesomeIcons.book;
    }
  }
}
