import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/flashcard_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/memory_cards_preview_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/repository/database_functions_name.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/repository/database_table_name.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/challenge_themes.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/memory_cards_preview.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryCardsSupabaseRepository implements MemoryCardsRepository {
  MemoryCardsSupabaseRepository(this._supabase, this._anonKey);

  final SupabaseClient _supabase;
  final String _anonKey;

  @override
  Future<Either<Failure, List<MemoryCardsPreview>>> getMemoryCardsList() async {
    try {
      final response = await _supabase
          .from(DatabaseTableName.theme_previews.name)
          .select()
          .filter('is_visible', 'eq', true)
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
      final response = await _supabase.rpc(
        DatabaseFunctionsName.get_flashcards_by_theme.name,
        params: {'theme_name': theme.name},
      );

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

  @override
  Future<Either<Failure, void>> addHint({
    required String flashcardId,
    required String? hint,
    required Uint8List? imageBytes,
    required String? fileName,
  }) async {
    final Map<String, dynamic> payload = {'translation_id': flashcardId};

    // Add text if provided
    if (hint case final String hintText when hintText.isNotEmpty) {
      payload['hint_text'] = hintText;
    }

    // Add image if provided (convert to base64)
    if (imageBytes != null && fileName != null) {
      final base64Image = base64Encode(imageBytes);

      // Determine MIME type from extension
      String mimeType = 'image/jpeg';
      final ext = fileName.split('.').last.toLowerCase();
      if (ext == 'png') {
        mimeType = 'image/png';
      } else if (ext == 'gif') {
        mimeType = 'image/gif';
      } else if (ext == 'webp') {
        mimeType = 'image/webp';
      }

      payload['image_base64'] = base64Image;
      payload['image_filename'] = fileName;
      payload['image_mime'] = mimeType;
    }

    try {
      await _supabase.functions.invoke(
        'add_hint',
        body: payload,
        headers: {
          'Authorization':
              'Bearer ${_supabase.auth.currentSession?.accessToken ?? _anonKey}',
        },
      );
    } catch (e, s) {
      return Left(
        Failure(
          technicalMessage: 'Failed to add hint: $e',
          type: FailureType.supabaseError,
          stackTrace: s,
        ),
      );
    }

    return Right(null);
  }

  @override
  Future<Either<Failure, String>> getFlashcardPicureHintUrl({
    required String picPath,
  }) async {
    try {
      final response = await _supabase.storage
          .from('user_translation_hint')
          .createSignedUrl(picPath, 3600);

      return Right(response);
    } catch (e, s) {
      return Left(
        Failure(
          technicalMessage: 'Failed to get flashcard picture hint URL: $e',
          type: FailureType.supabaseError,
          stackTrace: s,
        ),
      );
    }
  }
}
