import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/bloc/fetch/fetch_bloc.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard_hint.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

part 'flashcard_hint_event.dart';

class FlashcardHintBloc extends FetchBloc<FlashcardHint, String> {
  FlashcardHintBloc({
    required MemoryCardsRepository memoryCardsRepository,
    required String? stringHint,
  }) : _memoryCardsRepository = memoryCardsRepository,
       _stringHint = stringHint ?? '',
       super();

  final MemoryCardsRepository _memoryCardsRepository;
  final String _stringHint;

  @override
  Future<Either<Failure, FlashcardHint>> fetchModel(String? params) async {
    if (params case final String picturePath when picturePath.isNotEmpty) {
      final result = await _memoryCardsRepository.getFlashcardPicureHintUrl(
        picPath: picturePath,
      );
      return result.fold(
        ifLeft: (failure) => Left(failure),
        ifRight: (url) =>
            Right(FlashcardHint(stringHint: _stringHint, pictureUrl: url)),
      );
    }

    if (_stringHint.isNotEmpty) {
      return Right(FlashcardHint(stringHint: _stringHint, pictureUrl: ''));
    }

    return Left(
      Failure(
        technicalMessage: 'FlashcardHintBloc fetchModel params is required',
        type: FailureType.internalParamError,
        stackTrace: StackTrace.current,
      ),
    );
  }
}
