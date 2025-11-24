part of 'add_hint_bloc.dart';

sealed class AddHintEvent extends Equatable {
  const AddHintEvent();

  @override
  List<Object?> get props => [];
}

final class AddHintSubmitted extends AddHintEvent {
  const AddHintSubmitted({
    required this.literaId,
    required this.hint,
    this.imageBytes,
    this.fileName,
  });

  final String literaId;
  final String? hint;
  final Uint8List? imageBytes;
  final String? fileName;

  @override
  List<Object?> get props => [literaId, hint, imageBytes, fileName];
}
