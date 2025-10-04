import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/ui_kit/tiles/icon_tile.dart';
import 'package:provider/provider.dart';

class ChallangesSection extends StatelessWidget {
  const ChallangesSection({super.key, this.padding});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Практика',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          IconTile(
            onTap: () =>
                context.read<TiliNavigation>().goToVocablaryDashboard(context),
            icon: FontAwesomeIcons.book,
            title: 'Словарь',
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
