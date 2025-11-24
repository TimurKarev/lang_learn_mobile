import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get(String key, {String? fallback}) {
    return dotenv.env[key] ?? fallback ?? '';
  }

  // Supabase
  static String get supabaseUrl =>
      const String.fromEnvironment('SUPABASE_URL', defaultValue: '') != ''
      ? const String.fromEnvironment('SUPABASE_URL')
      : dotenv.env['SUPABASE_URL'] ?? '';

  static String get supabaseUrlLocal =>
      const String.fromEnvironment('SUPABASE_URL_LOCAL', defaultValue: '') != ''
      ? const String.fromEnvironment('SUPABASE_URL_LOCAL')
      : dotenv.env['SUPABASE_URL_LOCAL'] ?? '';

  static String get supabaseKey =>
      const String.fromEnvironment('SUPABASE_KEY', defaultValue: '') != ''
      ? const String.fromEnvironment('SUPABASE_KEY')
      : dotenv.env['SUPABASE_KEY'] ?? '';

  static String get supabaseKeyLocal =>
      const String.fromEnvironment('SUPABASE_KEY_LOCAL', defaultValue: '') != ''
      ? const String.fromEnvironment('SUPABASE_KEY_LOCAL')
      : dotenv.env['SUPABASE_KEY_LOCAL'] ?? '';

  // Clarity
  static String get clarityProjectIdDev =>
      const String.fromEnvironment(
            'CLARITY_PROJECT_ID_DEV',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('CLARITY_PROJECT_ID_DEV')
      : dotenv.env['CLARITY_PROJECT_ID_DEV'] ?? '';

  static String get clarityProjectIdProd =>
      const String.fromEnvironment(
            'CLARITY_PROJECT_ID_PROD',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('CLARITY_PROJECT_ID_PROD')
      : dotenv.env['CLARITY_PROJECT_ID_PROD'] ?? '';

  // Google
  static String get googleServerClientId =>
      const String.fromEnvironment(
            'GOOGLE_SERVER_CLIENT_ID',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID')
      : dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';

  static String get devGoogleServerClientId =>
      const String.fromEnvironment(
            'DEV_GOOGLE_SERVER_CLIENT_ID',
            defaultValue: '',
          ) !=
          ''
      ? const String.fromEnvironment('DEV_GOOGLE_SERVER_CLIENT_ID')
      : dotenv.env['DEV_GOOGLE_SERVER_CLIENT_ID'] ?? '';
}
