import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static String? get clarityProjectId => isDev
      ? dotenv.env['CLARITY_PROJECT_ID_DEV']
      : dotenv.env['CLARITY_PROJECT_ID_PROD'];

  static String? get googleServerClientId {
    if (isLocalSupabase) {
      return dotenv.env['GOOGLE_SERVER_CLIENT_ID'];
    }
    return isDev
        ? dotenv.env['DEV_GOOGLE_SERVER_CLIENT_ID']
        : dotenv.env['GOOGLE_SERVER_CLIENT_ID'];
  }
}
