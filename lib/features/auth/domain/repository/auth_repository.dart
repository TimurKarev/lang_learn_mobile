import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    show ProjectUser;

abstract class AuthRepository {
  Future<Either<Failure, ProjectUser>> signInAnonymously();
  Future<Either<Failure, ProjectUser>> signInWithGoogle();
  Stream<ProjectUser> authStateChange();
  Future<void> signOut();
}
