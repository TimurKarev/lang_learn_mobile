import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/avatar/presentation/tili_avatar.dart';
import 'package:lang_learn_mobile/features/home/presentation/sections/challanges_section.dart';
import 'package:lang_learn_mobile/features/home/presentation/sections/learning_path_section.dart';
import 'package:lang_learn_mobile/features/home/presentation/sections/offline_section.dart';
import 'package:lang_learn_mobile/ui_kit/cards/progress_card/progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 24,
        title: Text(
          'Главная',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: GestureDetector(child: TiliAvatar()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProgressCard(),
                LearningPathSection(padding: const EdgeInsets.only(top: 24)),
                ChallangesSection(padding: const EdgeInsets.only(top: 24)),
                OfflineSection(padding: const EdgeInsets.only(top: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
