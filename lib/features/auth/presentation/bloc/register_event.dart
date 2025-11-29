part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class RegisterConfirmPasswordChanged extends RegisterEvent {
  const RegisterConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class RegisterTermsChanged extends RegisterEvent {
  const RegisterTermsChanged(this.accepted);

  final bool accepted;

  @override
  List<Object> get props => [accepted];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
