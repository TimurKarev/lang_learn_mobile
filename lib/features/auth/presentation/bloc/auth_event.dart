part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();
}

class AuthSignInAnonymouslyEvent extends AuthEvent {
  const AuthSignInAnonymouslyEvent();
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}
