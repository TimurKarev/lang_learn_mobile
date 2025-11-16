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
    super.key,
  });

  final String title;
  final EdgeInsets padding;
  final ChallengeThemes theme;
  final VoidCallback? onTap;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoBadge(
                icon: _iconData,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                radius: 24,
                iconSize: 18,
              ),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.labelMedium),
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
        return FontAwesomeIcons.heartbeat;
      case ChallengeThemes.body_parts:
        return FontAwesomeIcons.user;
      case ChallengeThemes.city:
        return FontAwesomeIcons.city;
      case ChallengeThemes.clothes:
        return FontAwesomeIcons.tshirt;
      case ChallengeThemes.colors:
        return FontAwesomeIcons.palette;
      case ChallengeThemes.consumption_verbs:
        return FontAwesomeIcons.utensils;
      case ChallengeThemes.food:
        return FontAwesomeIcons.appleAlt;
      case ChallengeThemes.functional:
        return FontAwesomeIcons.cogs;
      case ChallengeThemes.furniture:
        return FontAwesomeIcons.couch;
      case ChallengeThemes.head:
        return FontAwesomeIcons.userCircle;
      case ChallengeThemes.household:
        return FontAwesomeIcons.house;
      case ChallengeThemes.interaction_verbs:
        return FontAwesomeIcons.handshake;
      case ChallengeThemes.mind_verbs:
        return FontAwesomeIcons.brain;
      case ChallengeThemes.movement_verbs:
        return FontAwesomeIcons.running;
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
        return FontAwesomeIcons.expandArrowsAlt;
      case ChallengeThemes.tools:
        return FontAwesomeIcons.wrench;
      case ChallengeThemes.vehicles:
        return FontAwesomeIcons.car;
      case ChallengeThemes.unknown:
        return FontAwesomeIcons.book;
    }
  }
}
