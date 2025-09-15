import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/flashcard_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/memory_cards_preview_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/vocabulary.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryCardsSupabaseRepository implements MemoryCardsRepository {
  MemoryCardsSupabaseRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList() async {
    try {
      final response = await _supabase
          .from('memory_cards_preview')
          .select()
          .order('created_at', ascending: true);

      if (response.isEmpty) {
        return Right([]);
      }

      final List<MemoryCardsPreview> cards = [];
      for (final item in response) {
        try {
          final dto = MemoryCardsPreviewDto.fromJson(item);
          cards.add(dto.toEntity());
        } catch (e) {
          continue;
        }
      }

      return Right(cards);
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch memory cards: ${e.message}'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Flashcard>>> getMemoryCardsForChallenge(
    ChallengeThemes theme,
  ) async {
    try {
      final conceptIds = await _getConceptIdsByTheme(theme.name);
      final response = await _supabase
          .from('flashcards')
          .select('''
      id,
      from_translations:translations!flashcards_from_translation_id_fkey(id, word, transcript, lang),
      to_translations:translations!flashcards_to_translation_id_fkey(id, word, transcript, lang)
    ''')
          .inFilter('concept_id', conceptIds)
          .order('order', ascending: true);

      if (response.isEmpty) {
        return Right([]);
      }

      final List<Flashcard> cards = [];
      for (final item in response) {
        try {
          final dto = FlashcardDto.fromJson(item);
          cards.add(dto.toEntity());
        } catch (e) {
          return Left(Failure('Flashcard mapping failed: $e'));
        }
      }

      return Right(cards);
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch flashcards: ${e.message}'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: $e'));
    }
  }

  Future<List<String>> _getConceptIdsByTheme(String theme) async {
    final response = await _supabase
        .from('concepts')
        .select('id')
        .eq('free_mode_theme', theme);
    return (response as List).map((json) => json['id'] as String).toList();
  }

  @override
  Future<Either<Failure, Vocabulary>> getInformation(String challengeId) async {
    try {
      // TODO: Uncomment and implement when ready
      // final response = await _supabase
      //     .from('vocabularies')
      //     .select()
      //     .eq('challenge_id', challengeId)
      //     .single();

      // TODO: Implement VocabularyDto and mapper
      return Left(Failure('Not implemented'));
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch vocabulary: ${e.message}'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: $e'));
    }
  }
}
