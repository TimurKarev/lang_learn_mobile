import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:lang_learn_mobile/core/config/env.dart';

class AppConfig {
  static const String _flavorKey = 'FLAVOR';
  static const String _localSupabaseKey = 'LOCAL_SUPABASE';

  static String get flavor =>
      const String.fromEnvironment(_flavorKey, defaultValue: 'prod');
  static bool get isLocalSupabase =>
      const bool.fromEnvironment(_localSupabaseKey, defaultValue: false);

  static bool get isDev => flavor == 'dev';
  static bool get isProd => flavor == 'prod';

  static bool get isAnalyticsEnabled => isDev || isProd;

  static LogLevel get logLevel => isDev ? LogLevel.Info : LogLevel.None;

  static String? get clarityProjectId =>
      isDev ? Env.clarityProjectIdDev : Env.clarityProjectIdProd;

  static String? get googleServerClientId {
    if (isLocalSupabase) {
      return Env.googleServerClientId;
    }
    return isDev ? Env.devGoogleServerClientId : Env.googleServerClientId;
  }

  static String? get iosGoogleServerClientId {
    return Env.iosGoogleServerClientId;
  }
}
