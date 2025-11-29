part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.termsAccepted = false,
    this.errorMessage,
  });

  final RegisterStatus status;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool termsAccepted;
  final String? errorMessage;

  RegisterState copyWith({
    RegisterStatus? status,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? termsAccepted,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    name,
    email,
    password,
    confirmPassword,
    termsAccepted,
    errorMessage,
  ];
}
