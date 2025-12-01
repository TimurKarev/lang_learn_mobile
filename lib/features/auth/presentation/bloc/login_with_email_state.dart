part of 'login_with_email_bloc.dart';

enum LoginWithEmailStatus { initial, loading, success, failure }

class LoginWithEmailState extends Equatable {
  final LoginWithEmailStatus status;
  final String email;
  final String password;
  final String? errorMessage;

  const LoginWithEmailState({
    this.status = LoginWithEmailStatus.initial,
    this.email = '',
    this.password = '',
    this.errorMessage,
  });

  bool canSubmit() {
    return status != LoginWithEmailStatus.loading &&
        email.isNotEmpty &&
        password.isNotEmpty;
  }

  LoginWithEmailState copyWith({
    LoginWithEmailStatus? status,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return LoginWithEmailState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, email, password, errorMessage];
}
