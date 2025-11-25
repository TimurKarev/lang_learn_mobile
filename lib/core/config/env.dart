class Env {
  static String get(String key, {String? fallback}) {
    final value = String.fromEnvironment(key, defaultValue: '');
    return value.isNotEmpty ? value : (fallback ?? '');
  }

  // Supabase
  static String get supabaseUrl =>
      const String.fromEnvironment('SUPABASE_URL', defaultValue: '');

  static String get supabaseUrlLocal =>
      const String.fromEnvironment('SUPABASE_URL_LOCAL', defaultValue: '');

  static String get supabaseKey =>
      const String.fromEnvironment('SUPABASE_KEY', defaultValue: '');

  static String get supabaseKeyLocal =>
      const String.fromEnvironment('SUPABASE_KEY_LOCAL', defaultValue: '');

  // Clarity
  static String get clarityProjectIdDev =>
      const String.fromEnvironment('CLARITY_PROJECT_ID_DEV', defaultValue: '');

  static String get clarityProjectIdProd =>
      const String.fromEnvironment('CLARITY_PROJECT_ID_PROD', defaultValue: '');

  // Google
  static String get googleServerClientId =>
      const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID', defaultValue: '');

  static String get devGoogleServerClientId => const String.fromEnvironment(
    'DEV_GOOGLE_SERVER_CLIENT_ID',
    defaultValue: '',
  );

  static String get iosGoogleServerClientId => const String.fromEnvironment(
    'IOS_GOOGLE_SERVER_CLIENT_ID',
    defaultValue: '',
  );
}
