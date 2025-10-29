import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';

void main() {
  group('AppFlavorConfig Tests', () {
    setUp(() {
      // Reset flavor before each test
      AppFlavorConfig.initialize('prod');
    });

    test('dev flavor should enable analytics and use Info log level', () {
      AppFlavorConfig.initialize('dev');

      expect(AppFlavorConfig.isAnalyticsEnabled, true);
      expect(AppFlavorConfig.logLevel, LogLevel.Info);
    });

    test(
      'dev_no_analytics flavor should disable analytics and use Info log level',
      () {
        AppFlavorConfig.initialize('dev_no_analytics');

        expect(AppFlavorConfig.isAnalyticsEnabled, false);
        expect(AppFlavorConfig.logLevel, LogLevel.Info);
      },
    );

    test('prod flavor should enable analytics and use None log level', () {
      AppFlavorConfig.initialize('prod');

      expect(AppFlavorConfig.isAnalyticsEnabled, true);
      expect(AppFlavorConfig.logLevel, LogLevel.None);
    });

    test('unknown flavor should default to prod settings', () {
      AppFlavorConfig.initialize('unknown');

      expect(AppFlavorConfig.isAnalyticsEnabled, true);
      expect(AppFlavorConfig.logLevel, LogLevel.None);
    });
  });
}
