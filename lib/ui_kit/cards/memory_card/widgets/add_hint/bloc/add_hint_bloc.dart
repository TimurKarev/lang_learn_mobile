import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/repositories/memory_cards_repository.dart';

part 'add_hint_event.dart';
part 'add_hint_state.dart';

class AddHintBloc extends Bloc<AddHintEvent, AddHintState> {
  AddHintBloc({required MemoryCardsRepository memoryCardsRepository})
    : _memoryCardsRepository = memoryCardsRepository,
      super(AddHintInitial()) {
    on<AddHintSubmitted>(_onAddHintSubmitted);
  }

  final MemoryCardsRepository _memoryCardsRepository;

  Future<void> _onAddHintSubmitted(
    AddHintSubmitted event,
    Emitter<AddHintState> emit,
  ) async {
    emit(AddHintLoading());

    File? imageFile;
    if (event.imagePath case final String imagePath when imagePath.isNotEmpty) {
      imageFile = File(imagePath);
    }

    final result = await _memoryCardsRepository.addHint(
      flashcardId: event.literaId,
      hint: event.hint,
      imageFile: imageFile,
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
