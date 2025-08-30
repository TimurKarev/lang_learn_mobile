import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/memory_cards/presentation/cards_dashboard/cards_dashboard_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // GoRouter configuration
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const CardsDashboardPage();
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}
