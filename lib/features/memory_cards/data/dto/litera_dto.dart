import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';
import 'package:lang_learn_mobile/core/mappers/dto_mapper.dart';

class LiteralDto implements DtoMapper<Literal> {
  final String id;
  final String word;
  final String transcript;
  final String lang;
  final bool? hasAudio;
  final String? stringHint;
  final String? imagePath;

  const LiteralDto({
    required this.id,
    required this.word,
    required this.transcript,
    required this.lang,
    this.hasAudio,
    this.stringHint,
    this.imagePath,
  });

  @override
  Literal toEntity() {
    return Literal(
      id: id,
      word: word,
      transcript: transcript,
      lang: Languages.getByName(lang),
      hasAudio: hasAudio ?? false,
      stringHint: stringHint ?? '',
      imagePath: imagePath ?? '',
    );
  }
}
