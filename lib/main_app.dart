import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart' show DiLocator;
import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:lang_learn_mobile/ui_kit/ui_kit.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<bool> _auth() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      // No existing session - create anonymous user
      await Supabase.instance.client.auth.signInAnonymously();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _auth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == false) {
          return MaterialApp(
            home: ErrorScreen(
              title: 'Error',
              message: 'Something went wrong in auth',
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Provider<DiLocator>(
            create: (context) => DiLocator(ObjectContainer({})),
            child: MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              routerConfig: AppRoutes.router,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
