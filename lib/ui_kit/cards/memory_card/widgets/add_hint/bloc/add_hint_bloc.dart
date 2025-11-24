import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/core/services/image_compression_service.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

part 'add_hint_event.dart';
part 'add_hint_state.dart';

class AddHintBloc extends Bloc<AddHintEvent, AddHintState> {
  AddHintBloc({
    required MemoryCardsRepository memoryCardsRepository,
    required ImageCompressionService imageCompressionService,
  }) : _memoryCardsRepository = memoryCardsRepository,
       _imageCompressionService = imageCompressionService,
       super(AddHintInitial()) {
    on<AddHintSubmitted>(_onAddHintSubmitted);
  }

  final MemoryCardsRepository _memoryCardsRepository;
  final ImageCompressionService _imageCompressionService;

  Future<void> _onAddHintSubmitted(
    AddHintSubmitted event,
    Emitter<AddHintState> emit,
  ) async {
    emit(AddHintLoading());

    Uint8List? imageBytes;
    if (event.imageBytes case final Uint8List bytes when bytes.isNotEmpty) {
      imageBytes = await _imageCompressionService.compressImage(
        imageBytes: bytes,
      );
    }

    final result = await _memoryCardsRepository.addHint(
      flashcardId: event.literaId,
      hint: event.hint,
      imageBytes: imageBytes,
      fileName: event.fileName,
    );

    result.fold(
      ifLeft: (failure) => emit(
        AddHintFailure(
          error: UiError(
            title: failure.technicalMessage,
            displayType: ErrorDisplayType.toast,
            description: failure.technicalMessage,
          ),
        ),
      ),
      ifRight: (_) => emit(AddHintSuccess()),
    );
  }
}
