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
    this.imagePath,
  });

  final String literaId;
  final String? hint;
  final String? imagePath;

  @override
  List<Object?> get props => [literaId, hint, imagePath];
}
