part of 'add_hint_bloc.dart';

sealed class AddHintState extends Equatable {
  const AddHintState();

  @override
  List<Object> get props => [];
}

final class AddHintInitial extends AddHintState {}

final class AddHintLoading extends AddHintState {}

final class AddHintSuccess extends AddHintState {}

final class AddHintFailure extends AddHintState {
  const AddHintFailure({required this.error});

  final UiError error;

  @override
  List<Object> get props => [error];
}
