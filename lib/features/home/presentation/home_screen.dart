import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/features/avatar/presentation/tili_avatar.dart'
    show TiliAvatar;
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
            child: GestureDetector(
              child: TiliAvatar(),
              onTap: () => _showLogoutDialog(context),
            ),
          ),
        ],
      ),
      body: Padding(
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
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context.read<AuthBloc>().add(
                  AuthSingoutEvent(),
                ); // Perform logout
              },
              child: const Text('LOGOUT'),
            ),
          ],
        );
      },
    );
  }
}
