import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/ui_kit/error_placeholder/error_placeholder.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.error});

  final UiError? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: ErrorPlaceholder(
            error:
                error ??
                UiError(
                  title: 'Unknown Error',
                  description: 'An unknown error occurred',
                  displayType: ErrorDisplayType.screen,
                ),
          ),
        ),
      ),
    );
  }
}
