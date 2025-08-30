import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart' show DiLocator;
import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
}
