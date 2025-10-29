import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { dev, prod }

class AppFlavorConfig {
  static AppFlavor? _currentFlavor;

  static void initialize(String flavorName) {
    switch (flavorName.toLowerCase()) {
      case 'dev':
        _currentFlavor = AppFlavor.dev;
        break;
      case 'prod':
        _currentFlavor = AppFlavor.prod;
        break;
      default:
        _currentFlavor = AppFlavor.prod;
    }
  }

  static bool get isAnalyticsEnabled => isAnalyticsEnabledForFlavor();

  static LogLevel get logLevel => getLogLevelForFlavor();

  static String? get clarityProjectId => getClarityProjectIdForFlavor();

  static bool isAnalyticsEnabledForFlavor() {
    switch (_currentFlavor) {
      case AppFlavor.dev:
      case AppFlavor.prod:
      case null:
        return true;
    }
  }

  static LogLevel getLogLevelForFlavor() {
    switch (_currentFlavor) {
      case AppFlavor.dev:
        return LogLevel.Info;
      case AppFlavor.prod:
        return LogLevel.None;
      case null:
        return LogLevel.None;
    }
  }

  static String? getClarityProjectIdForFlavor() {
    switch (_currentFlavor) {
      case AppFlavor.dev:
        return dotenv.env['CLARITY_PROJECT_ID_DEV'];
      case AppFlavor.prod:
      case null:
        return dotenv.env['CLARITY_PROJECT_ID_PROD'];
    }
  }

  static String? get googleServerClientId {
    switch (_currentFlavor) {
      case AppFlavor.dev:
        return dotenv.env['DEV_GOOGLE_SERVER_CLIENT_ID'];
      case AppFlavor.prod:
      case null:
        return dotenv.env['GOOGLE_SERVER_CLIENT_ID'];
    }
  }
}
