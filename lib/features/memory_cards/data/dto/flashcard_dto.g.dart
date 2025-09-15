// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashcardDto _$FlashcardDtoFromJson(Map<String, dynamic> json) => FlashcardDto(
  id: json['id'] as String,
  fWord: LiteralDto.fromJson(json['from_translations'] as Map<String, dynamic>),
  sWord: LiteralDto.fromJson(json['to_translations'] as Map<String, dynamic>),
);
