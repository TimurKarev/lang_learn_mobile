import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/data/enitity_mapper.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/falshcard_settings_dto.dart';

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
        repeatWrong: true,
        askLanguage: Languages.russian,
      );

  @override
  List<Object?> get props => [shufleCards, repeatWrong, askLanguage];
}

class FlashcardsSettingsMapper
    implements EntityMapperMixin<FlashcardsSettings, FalshcardSettingsDto> {
  @override
  FlashcardsSettings mapToEntity(FalshcardSettingsDto dto) {
    return FlashcardsSettings(
      shufleCards: dto.shufleCards,
      repeatWrong: dto.repeatWrong,
      askLanguage: Languages.getByName(dto.askLanguage),
    );
  }

  @override
  FalshcardSettingsDto mapToDto(FlashcardsSettings entity) {
    return FalshcardSettingsDto(
      shufleCards: entity.shufleCards,
      repeatWrong: entity.repeatWrong,
      askLanguage: entity.askLanguage.name,
    );
  }
}
