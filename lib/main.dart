import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lang_learn_mobile/main_app.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String get flavor => String.fromEnvironment('FLAVOR', defaultValue: 'prod');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Initialize flavor from dart-define
  AppFlavorConfig.initialize(flavor);

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];

  if (supabaseUrl != null && supabaseKey != null) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    runApp(const MainApp());
  } else {
    throw Exception('Supabase URL or key not found in .env file');
  }
}
