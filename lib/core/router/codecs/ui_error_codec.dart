import 'dart:convert';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';

class UiErrorCodec extends Codec<UiError, String> {
  const UiErrorCodec();

  @override
  Converter<UiError, String> get encoder => const _UiErrorEncoder();

  @override
  Converter<String, UiError> get decoder => const _UiErrorDecoder();
}

class _UiErrorEncoder extends Converter<UiError, String> {
  const _UiErrorEncoder();

  @override
  String convert(UiError input) {
    final map = {
      'title': input.title,
      'description': input.description,
      'displayType': input.displayType.name,
    };
    return jsonEncode(map);
  }
}

class _UiErrorDecoder extends Converter<String, UiError> {
  const _UiErrorDecoder();

  @override
  UiError convert(String input) {
    final map = jsonDecode(input) as Map<String, dynamic>;
    return UiError(
      title: map['title'] as String,
      description: map['description'] as String,
      displayType: ErrorDisplayType.values.firstWhere(
        (e) => e.name == map['displayType'],
        orElse: () => ErrorDisplayType.unknown,
      ),
    );
  }
}
