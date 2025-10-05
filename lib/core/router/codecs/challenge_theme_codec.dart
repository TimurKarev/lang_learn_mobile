import 'dart:convert';

import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';

class ChallengeThemesCodec extends Codec<ChallengeThemes?, String> {
  const ChallengeThemesCodec();

  @override
  Converter<ChallengeThemes?, String> get encoder =>
      const _ChallengeThemesEncoder();

  @override
  Converter<String, ChallengeThemes?> get decoder =>
      const _ChallengeThemesDecoder();
}

class _ChallengeThemesEncoder extends Converter<ChallengeThemes?, String> {
  const _ChallengeThemesEncoder();

  @override
  String convert(ChallengeThemes? input) => input?.name ?? 'unknown';
}

class _ChallengeThemesDecoder extends Converter<String, ChallengeThemes?> {
  const _ChallengeThemesDecoder();

  @override
  ChallengeThemes? convert(String input) {
    if (input.isEmpty) return null;
    return ChallengeThemes.getByName(
      input,
      defaultValue: ChallengeThemes.unknown,
    );
  }
}
