import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lang_learn_mobile/main_app.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lang_learn_mobile/core/config/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final supabaseUrl = AppConfig.isLocalSupabase
      ? Env.supabaseUrlLocal
      : Env.supabaseUrl;
  final supabaseKey = AppConfig.isLocalSupabase
      ? Env.supabaseKeyLocal
      : Env.supabaseKey;

  if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    runApp(const MainApp());
  } else {
    throw Exception('Supabase URL or key not found in environment variables');
  }
}
