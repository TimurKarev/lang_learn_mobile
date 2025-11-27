import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class TiliAvatar extends StatelessWidget {
  const TiliAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLogoutDialog(context),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 18,
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logout),
          content: Text(AppLocalizations.of(context)!.logoutConfirmation),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context.read<AuthBloc>().add(
                  AuthSingoutEvent(),
                ); // Perform logout
              },
              child: Text(AppLocalizations.of(context)!.logout.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
