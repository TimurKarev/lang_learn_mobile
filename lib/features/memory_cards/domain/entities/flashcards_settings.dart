import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';

class FlashcardsSettings extends Equatable {
  final bool shufleCards;
  final bool repeatWrong;
  final Languages askLanguage;

  const FlashcardsSettings({
    required this.shufleCards,
    required this.repeatWrong,
    required this.askLanguage,
  });

  const FlashcardsSettings.initial()
    : this(
        shufleCards: false,
        repeatWrong: false,
        askLanguage: Languages.kyrgyz,
      );

  @override
  List<Object?> get props => [shufleCards, repeatWrong, askLanguage];
}
