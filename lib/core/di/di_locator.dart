import 'package:lang_learn_mobile/core/audio_player/just_audio_player.dart';
import 'package:lang_learn_mobile/core/audio_player/tili_audio_player.dart';
import 'package:lang_learn_mobile/core/config/env.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:lang_learn_mobile/core/di/object_container.dart';
import 'package:lang_learn_mobile/core/services/image_compression_service.dart';
import 'package:lang_learn_mobile/features/auth/data/repository/auth_supabase_repository.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart'
    show AuthRepository;
import 'package:lang_learn_mobile/features/memory_cards/data/repository/falshcard_settings_supabase_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/data/repository/memory_cards_supabase_repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/flashcard_settings.repository.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lang_learn_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

class DiLocator {
  const DiLocator(this._objectContainer);

  final ObjectContainer _objectContainer;

  T get<T extends Object>({bool keepAlive = false, bool mock = false}) {
    final object = _objectContainer.getObject<T>();
    if (object != null) {
      return object;
    }

    if (T == MemoryCardsRepository) {
      final MemoryCardsRepository newObject;
      if (mock) {
        newObject = MemoryCardsRepositoryMock();
      } else {
        final anonKey = AppConfig.isLocalSupabase
            ? Env.supabaseKeyLocal
            : Env.supabaseKey;
        newObject = MemoryCardsSupabaseRepository(
          Supabase.instance.client,
          anonKey,
        );
      }
      if (keepAlive) {
        _objectContainer.add(newObject);
      }
      return newObject as T;
    }

    if (T == FlashcardSettingsRepository) {
      final FlashcardSettingsRepository newObject;
      if (mock) {
        throw Exception('Mock not implemented');
      } else {
        newObject = FalshcardSettingsSupabaseRepository(
          Supabase.instance.client,
        );
      }
      if (keepAlive) {
        _objectContainer.add(newObject);
      }
      return newObject as T;
    }

    if (T == OnboardingRepository) {
      final OnboardingRepository onboardingRepo;
      if (mock) {
        onboardingRepo = MockOnboardingRepository();
      } else {
        throw Exception('Real implementation not implemented');
      }
      if (keepAlive) {
        _objectContainer.add(onboardingRepo);
      }
      return onboardingRepo as T;
    }

    if (T == AuthRepository) {
      final AuthRepository authRepo;
      if (mock) {
        throw Exception('Mock not implemented');
      } else {
        authRepo = AuthSupabaseRepository();
      }
      if (keepAlive) {
        _objectContainer.add(authRepo);
      }
      return authRepo as T;
    }

    if (T == TiliAudioPlayer) {
      final TiliAudioPlayer audioPlayer;
      if (mock) {
        throw Exception('Mock not implemented');
      } else {
        audioPlayer = JustAudioPlayer();
      }
      if (keepAlive) {
        _objectContainer.add(audioPlayer);
      }
      return audioPlayer as T;
    }

    if (T == ImageCompressionService) {
      final ImageCompressionService imageCompressionService;
      if (mock) {
        throw Exception('Mock not implemented');
      } else {
        imageCompressionService = ImageCompressionServiceImpl();
      }
      if (keepAlive) {
        _objectContainer.add(imageCompressionService);
      }
      return imageCompressionService as T;
    }

    throw Exception('Object not found');
  }
}
