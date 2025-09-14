import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/data/enitity_mapper.dart';
import 'package:lang_learn_mobile/core/entities/languages.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/falshcard_settings_dto.dart';

class FlashcardsSettings extends Equatable {
  final bool isShufleCards;
  final bool isRepeatWrong;
  final Languages askLanguage;

  const FlashcardsSettings({
    required this.isShufleCards,
    required this.isRepeatWrong,
    required this.askLanguage,
  });

  const FlashcardsSettings.initial()
    : this(
        isShufleCards: false,
        isRepeatWrong: true,
        askLanguage: Languages.ru,
      );

  @override
  List<Object?> get props => [isShufleCards, isRepeatWrong, askLanguage];
}

class FlashcardsSettingsMapper
    implements EntityMapperMixin<FlashcardsSettings, FalshcardSettingsDto> {
  @override
  FlashcardsSettings mapToEntity(FalshcardSettingsDto dto) {
    return FlashcardsSettings(
      isShufleCards: dto.isShufle,
      isRepeatWrong: dto.isRepeatWrongCard,
      askLanguage: Languages.getByName(dto.askLanguage),
    );
  }

  @override
  FalshcardSettingsDto mapToDto(FlashcardsSettings entity) {
    return FalshcardSettingsDto(
      isShufle: entity.isShufleCards,
      isRepeatWrongCard: entity.isRepeatWrong,
      askLanguage: entity.askLanguage.name,
    );
  }
}
