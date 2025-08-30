import 'package:equatable/equatable.dart';

class MemoryCardsPreview extends Equatable {
  const MemoryCardsPreview({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  @override
  List<Object?> get props => [id, title, description];
}
