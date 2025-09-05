import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/entities/litera.dart';

class MemoryCard extends Equatable {
  final String id;

  final Literal fWord;
  final Literal sWord;

  const MemoryCard({
    required this.id,
    required this.fWord,
    required this.sWord,
  });

  @override
  List<Object?> get props => [id, fWord, sWord];
}
