import 'package:equatable/equatable.dart';

class FlashcardHint extends Equatable {
  final String stringHint;
  final String pictureUrl;

  const FlashcardHint({required this.stringHint, required this.pictureUrl});

  @override
  List<Object> get props => [stringHint, pictureUrl];
}
