import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';

class MemoryCardsPreview extends Equatable {
  const MemoryCardsPreview({
    required this.id,
    required this.title,
    required this.description,
    required this.theme,
  });

  final String id;
  final String title;
  final String description;
  final ChallengeThemes theme;

  @override
  List<Object?> get props => [id, title, description, theme];
}
