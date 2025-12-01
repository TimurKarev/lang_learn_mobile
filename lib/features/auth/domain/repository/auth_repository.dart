import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    show ProjectUser;

abstract class AuthRepository {
  Future<Either<Failure, ProjectUser>> signInAnonymously();
  Future<Either<Failure, ProjectUser>> signInWithGoogle();
  Future<Either<Failure, ProjectUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, ProjectUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });
  Stream<ProjectUser> authStateChange();
  Future<void> signOut();
}
