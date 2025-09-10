import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lang_learn_mobile/main_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://qbdsidbpcsehkgnfbjig.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFiZHNpZGJwY3NlaGtnbmZiamlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczNTYwNDIsImV4cCI6MjA3MjkzMjA0Mn0.FAXfLQe4JKIDUvyb-1C_-QCgTfeDRb0kd4U0k1p2Z2M';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MainApp());
}
