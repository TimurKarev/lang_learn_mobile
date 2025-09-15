import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';
import 'package:lang_learn_mobile/core/mappers/dto_mapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'litera_dto.g.dart';

@JsonSerializable(createToJson: false)
class LiteralDto implements DtoMapper<Literal> {
  final String id;
  final String word;
  final String transcript;
  final String lang;

  const LiteralDto({
    required this.id,
    required this.word,
    required this.transcript,
    required this.lang,
  });

  factory LiteralDto.fromJson(Map<String, dynamic> json) =>
      _$LiteralDtoFromJson(json);

  @override
  Literal toEntity() {
    return Literal(
      id: id,
      word: word,
      transcript: transcript,
      lang: Languages.getByName(lang),
    );
  }
}
