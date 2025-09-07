import 'package:equatable/equatable.dart';

class Literal extends Equatable {
  final String id;
  final String word;
  final String transcript;
  final String lang;

  const Literal({
    required this.id,
    required this.word,
    required this.transcript,
    required this.lang,
  });

  @override
  List<Object?> get props => [id, word, transcript, lang];
}
