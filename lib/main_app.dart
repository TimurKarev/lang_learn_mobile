import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/core/router/routes.dart';
import 'package:lang_learn_mobile/core/theme/tilit_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc()..add(AuthInitialEvent());
    _router = AppRoutes.router(_authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DiLocator(ObjectContainer()),
      child: BlocProvider.value(
        value: _authBloc,
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: TiliTheme.lightTheme,
          darkTheme: TiliTheme.darkTheme,
          themeMode: ThemeMode.light,
          routerConfig: _router,
        ),
      ),
    );
  }
}
