import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_learn_mobile/core/analytics/clarity_init.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:lang_learn_mobile/core/di/di_locator.dart';
import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/core/router/tili_navigation.dart';
import 'package:lang_learn_mobile/core/router/tili_routes.dart';
import 'package:lang_learn_mobile/core/theme/tilit_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _router;
  late final DiLocator _diLocator;

  @override
  void initState() {
    super.initState();
    _diLocator = DiLocator(ObjectContainer());
    _authBloc = AuthBloc(authRepository: _diLocator.get<AuthRepository>())
      ..add(AuthInitialEvent());
    _router = TiliRoutes.router(_authBloc);

    _initClarity();
  }

  void _initClarity() {
    final projectId = AppConfig.clarityProjectId;
    final logLevel = AppConfig.logLevel;
    final isAnalyticsEnabled = AppConfig.isAnalyticsEnabled;

    if (projectId != null) {
      final config = ClarityInit(
        projectId: projectId,
        logLevel: logLevel,
      ).getConfig();
      Clarity.initialize(context, config);

      if (!isAnalyticsEnabled) {
        Clarity.pause();
      }
    }
  }

  @override
  void dispose() {
    _authBloc.close();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => TiliNavigation()),
        RepositoryProvider.value(value: _diLocator),
      ],
      child: BlocProvider.value(
        value: _authBloc,
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: TiliTheme.lightTheme,
          darkTheme: TiliTheme.darkTheme,
          themeMode: ThemeMode.light,
          routerConfig: _router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
