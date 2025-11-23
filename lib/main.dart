import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lang_learn_mobile/main_app.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load .env file
  await dotenv.load(fileName: ".env");

  final supabaseUrl = AppConfig.isLocalSupabase
      ? dotenv.env['SUPABASE_URL_LOCAL']
      : dotenv.env['SUPABASE_URL'];
  final supabaseKey = AppConfig.isLocalSupabase
      ? dotenv.env['SUPABASE_KEY_LOCAL']
      : dotenv.env['SUPABASE_KEY'];

  if (supabaseUrl != null && supabaseKey != null) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    runApp(const MainApp());
  } else {
    throw Exception('Supabase URL or key not found in .env file');
  }
}
