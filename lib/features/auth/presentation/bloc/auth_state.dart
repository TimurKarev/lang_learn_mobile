part of 'auth_bloc.dart';

sealed class ProjectUser extends Equatable {
  const ProjectUser();

  @override
  List<Object?> get props => [];
}

final class AuthenticatedUser extends ProjectUser {
  const AuthenticatedUser({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class UnauthenticatedUser extends ProjectUser {
  const UnauthenticatedUser([this.error]);

  final UiError? error;

  @override
  List<Object?> get props => [error];
}
