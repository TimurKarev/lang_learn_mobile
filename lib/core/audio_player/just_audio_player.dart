import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/audio_player/tili_audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JustAudioPlayer implements TiliAudioPlayer {
  JustAudioPlayer();

  final supabase = Supabase.instance.client;

  @override
  Future<Either<Failure, void>> playAudio({required String literalId}) async {
    String? audioUrl;
    try {
      // throw Exception('Test exception');
      audioUrl = await supabase.storage
          .from('translation_audio')
          .createSignedUrl('$literalId.mp3', 3600);
    } catch (e, s) {
      return Left(
        Failure(
          type: FailureType.supabaseError,
          technicalMessage: 'Failed to create audio URL',
          stackTrace: s,
          error: e,
        ),
      );
    }

    try {
      final player = AudioPlayer();
      await player.setUrl(audioUrl);
      await player.play();
      player.dispose();
    } catch (e, s) {
      return Left(
        Failure(
          type: FailureType.justAudioError,
          technicalMessage: 'Failed to play audio',
          stackTrace: s,
          error: e,
        ),
      );
    }
    return Right(null);
  }
}
