import 'package:equatable/equatable.dart';

class MemoryCard extends Equatable {
  final String id;

  final String fWord;
  final String fTranscript;
  final String fLang;

  final String sWord;
  final String sTranscript;
  final String sLang;

  const MemoryCard({
    required this.id,
    required this.fWord,
    required this.fTranscript,
    required this.sWord,
    required this.sTranscript,
    required this.fLang,
    required this.sLang,
  });

  @override
  List<Object?> get props => [
    id,
    fWord,
    sWord,
    fLang,
    sLang,
    fTranscript,
    sTranscript,
  ];
}
