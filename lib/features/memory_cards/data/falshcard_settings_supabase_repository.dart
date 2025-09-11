import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/dto/falshcard_settings_dto.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcards_settings.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FalshcardSettingsSupabaseRepository
    implements FlashcardSettingsRepository {
  FalshcardSettingsSupabaseRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<Either<Failure, void>> saveSettings(FlashcardsSettings settings) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FlashcardsSettings>> getSettings({
    required FlashcardsSettings defaultSettings,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      return Left(Failure('User is not authenticated'));
    }

    try {
      final response = await _supabase
          .from('flashcard_settings')
          .select()
          .eq('user_id', userId)
          .single();

      final dto = FalshcardSettingsDto.fromJson(response);
      return Right(FlashcardsSettingsMapper().mapToEntity(dto));
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Right(defaultSettings);
      }
      return Left(Failure('Failed to get settings'));
    } catch (e) {
      return Left(Failure('Failed to get settings'));
    }
  }
}
