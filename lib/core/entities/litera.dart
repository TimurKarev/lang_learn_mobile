import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';

class Literal extends Equatable {
  final String id;
  final String word;
  final String transcript;
  final Languages lang;
  final bool hasAudio;
  final String stringHint;
  final String imagePath;

  const Literal({
    required this.id,
    required this.word,
    required this.transcript,
    required this.lang,
    required this.hasAudio,
    required this.stringHint,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    id,
    word,
    transcript,
    lang,
    hasAudio,
    stringHint,
    imagePath,
  ];
}
