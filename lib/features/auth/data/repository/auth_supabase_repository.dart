import 'package:dart_either/dart_either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:lang_learn_mobile/core/config/flavor_config.dart';
import 'package:lang_learn_mobile/core/error_handling/failure.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    show ProjectUser, AuthenticatedUser, UnauthenticatedUser;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      if (kIsWeb) {
        await _supabase.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: kIsWeb
              ? (AppConfig.isLocalSupabase ? 'http://127.0.0.1:3000' : null)
              : 'io.supabase.flutter://login-callback/',
        );
        // On Web, this triggers a redirect, so the return value doesn't matter much
        // as the app will reload.
        return Right(UnauthenticatedUser());
      }

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      final serverClientId = AppConfig.googleServerClientId;
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
