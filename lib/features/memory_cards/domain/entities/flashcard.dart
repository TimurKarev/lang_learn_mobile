import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';

class Flashcard extends Equatable {
  final String id;

  final Literal fWord;
  final Literal sWord;
  final String stringHint;
  final String imagePath;

  const Flashcard({
    required this.id,
    required this.fWord,
    required this.sWord,
    this.stringHint = '',
    this.imagePath = '',
  });

  Flashcard revert() {
    return Flashcard(
      id: id,
      fWord: sWord,
      sWord: fWord,
      stringHint: stringHint,
      imagePath: imagePath,
    );
  }

  @override
  List<Object?> get props => [id, fWord, sWord, stringHint, imagePath];
}
