import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lang_learn_mobile/ui_kit/svg/svg_path.dart';

import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(SvgPath.puma, height: 128, width: 128),

              Text(
                AppLocalizations.of(context)!.kyrgyzLanguage,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
