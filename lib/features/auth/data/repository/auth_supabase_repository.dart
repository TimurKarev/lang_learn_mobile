import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    show ProjectUser, AuthenticatedUser, UnauthenticatedUser;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthSupabaseRepository implements AuthRepository {
  GoTrueClient get _supabase => Supabase.instance.client.auth;

  AuthSupabaseRepository();

  @override
  Future<Either<Failure, ProjectUser>> signInAnonymously() async {
    final result = await _supabase.signInAnonymously();
    if (result.session?.user case final User user) {
      return Right(AuthenticatedUser(id: user.id));
    }
    return Left(
      Failure(
        technicalMessage: 'Aunonimus auth failed',
        type: FailureType.authFailed,
        stackTrace: StackTrace.current,
      ),
    );
  }

  @override
  Future<Either<Failure, ProjectUser>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      final serverClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'];
      final iosServerClientId = dotenv.env['IOS_GOOGLE_SERVER_CLIENT_ID'];
      if (serverClientId == null) {
        return Left(
          Failure(
            technicalMessage: 'serverClientId is null',
            type: FailureType.authFailed,
            stackTrace: StackTrace.current,
          ),
        );
      }
      if (iosServerClientId == null) {
        return Left(
          Failure(
            technicalMessage: 'iosServerClientId is null',
            type: FailureType.authFailed,
            stackTrace: StackTrace.current,
          ),
        );
      }

      await googleSignIn.initialize(
        serverClientId: serverClientId,
        clientId: iosServerClientId,
      );

      // Start the lightweight authentication process
      await googleSignIn.attemptLightweightAuthentication();

      // Try to authenticate the user
      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.authenticate();
      } catch (e, s) {
        return Left(
          Failure(
            technicalMessage: 'Google sign in error: $e',
            type: FailureType.authFailed,
            error: e,
            stackTrace: s,
          ),
        );
      }

      // Get authentication tokens
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;
      if (idToken == null) {
        return Left(
          Failure(
            technicalMessage: 'idToken is null',
            type: FailureType.authFailed,
            stackTrace: StackTrace.current,
          ),
        );
      }

      final result = await _supabase.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (result.session?.user case final User user) {
        return Right(AuthenticatedUser(id: user.id));
      }

      return Left(
        Failure(
          technicalMessage: 'User is null',
          type: FailureType.authFailed,
          stackTrace: StackTrace.current,
        ),
      );
    } catch (e, s) {
      return Left(
        Failure(
          technicalMessage: 'Google sign in error: $e',
          type: FailureType.authFailed,
          error: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Stream<ProjectUser> authStateChange() {
    return _supabase.onAuthStateChange.map((event) {
      if (event.session?.user case final User user) {
        return AuthenticatedUser(id: user.id);
      }
      return UnauthenticatedUser();
    });
  }

  @override
  Future<void> signOut() {
    return _supabase.signOut();
  }
}
