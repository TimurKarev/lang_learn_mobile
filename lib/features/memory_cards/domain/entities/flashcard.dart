import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';

class Flashcard extends Equatable {
  final String id;

  final Literal fWord;
  final Literal sWord;

  const Flashcard({required this.id, required this.fWord, required this.sWord});

  Flashcard revert() {
    return Flashcard(id: id, fWord: sWord, sWord: fWord);
  }

  @override
  List<Object?> get props => [id, fWord, sWord];
}
