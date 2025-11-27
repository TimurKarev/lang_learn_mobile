import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/ui_kit/tiles/icon_tile.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class OfflineSection extends StatelessWidget {
  const OfflineSection({super.key, this.padding});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.practice,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          IconTile(
            icon: FontAwesomeIcons.user,
            title: l10n.findTeacher,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            foregroundColor: Theme.of(context).colorScheme.outline,
            disabled: true,
          ),
          const SizedBox(height: 8),
          IconTile(
            icon: FontAwesomeIcons.users,
            title: l10n.conversationClubs,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            foregroundColor: Theme.of(context).colorScheme.outline,
            disabled: true,
          ),
        ],
      ),
    );
  }
}
