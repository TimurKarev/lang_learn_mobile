part of 'login_with_email_bloc.dart';

abstract class LoginWithEmailEvent extends Equatable {
  const LoginWithEmailEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginWithEmailEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginWithEmailEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginWithEmailEvent {
  const LoginSubmitted();
}
