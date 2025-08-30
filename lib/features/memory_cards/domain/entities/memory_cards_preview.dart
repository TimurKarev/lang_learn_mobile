import 'package:equatable/equatable.dart';

class MemoryCardsPreview extends Equatable {
  const MemoryCardsPreview({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}
