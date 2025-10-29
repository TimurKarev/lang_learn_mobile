import 'package:clarity_flutter/clarity_flutter.dart';

class ClarityInit {
  final String projectId;
  final LogLevel? logLevel;

  ClarityInit({required this.projectId, this.logLevel});

  ClarityConfig getConfig() =>
      ClarityConfig(projectId: projectId, logLevel: logLevel ?? LogLevel.None);
}
