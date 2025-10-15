import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/flashcard_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/memory_cards_preview_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
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
    } catch (e, s) {
      return Left(
        Failure(
          technicalMessage: 'Failed to fetch memory cards: $e',
          type: FailureType.supabaseError,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Flashcard>>> getMemoryCardsForChallenge(
    ChallengeThemes theme,
  ) async {
    try {
      final response = await _supabase
          .rpc('get_flashcards_by_theme', params: {'theme_name': theme.name})
          .order('card_order', ascending: true);

      if (response.isEmpty) {
        return Right([]);
      }

      final List<Flashcard> cards = [];
      for (final item in response) {
        try {
          final dto = FlashcardDto.fromJson(item);
          cards.add(dto.toEntity());
        } catch (e, s) {
          return Left(
            Failure(
              technicalMessage: 'Flashcard mapping failed: $e',
              type: FailureType.mappingError,
              stackTrace: s,
            ),
          );
        }
      }

      return Right(cards);
    } catch (e, s) {
      return Left(
        Failure(
          technicalMessage: 'Failed to fetch flashcards: $e',
          type: FailureType.supabaseError,
          stackTrace: s,
        ),
      );
    }
  }
}
