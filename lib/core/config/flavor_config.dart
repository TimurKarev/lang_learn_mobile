import 'package:clarity_flutter/clarity_flutter.dart';

enum AppFlavor { dev, devNoAnalytics, prod }

class AppFlavorConfig {
  static AppFlavor? _currentFlavor;

  static void initialize(String flavorName) {
    switch (flavorName.toLowerCase()) {
      case 'dev':
        _currentFlavor = AppFlavor.dev;
        break;
      case 'dev_no_analytics':
        _currentFlavor = AppFlavor.devNoAnalytics;
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

  static bool isAnalyticsEnabledForFlavor() {
    switch (_currentFlavor) {
      case AppFlavor.devNoAnalytics:
        return false;
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
      case AppFlavor.devNoAnalytics:
        return LogLevel.Info;
      case AppFlavor.prod:
        return LogLevel.None;
      case null:
        return LogLevel.None;
    }
  }
}
