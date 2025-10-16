import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';

abstract interface class TiliAudioPlayer {
  Future<Either<Failure, void>> playAudio({required String literalId});
}
