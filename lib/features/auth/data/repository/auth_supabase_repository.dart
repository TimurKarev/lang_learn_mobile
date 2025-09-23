import 'package:dart_either/dart_either.dart';
import 'package:lang_learn_mobile/core/falures/failure.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:lang_learn_mobile/features/auth/presentation/bloc/auth_bloc.dart'
    show ProjectUser, AuthenticatedUser, UnauthenticatedUser;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

// TODO: correct flow
class AuthSupabaseRepository implements AuthRepository {
  GoTrueClient get _supabase => Supabase.instance.client.auth;

  AuthSupabaseRepository();

  @override
  Future<Either<Failure, ProjectUser>> signInAnonymously() async {
    final result = await _supabase.signInAnonymously();
    if (result.session?.user case final User user) {
      return Right(AuthenticatedUser(id: user.id));
    }
    return Left(Failure('User not found'));
  }

  @override
  Future<Either<Failure, ProjectUser>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId:
            '545203080565-ln6rn4h0arv01giktaan9r1qkn7bf6dg.apps.googleusercontent.com',
      );

      // Start the lightweight authentication process
      await googleSignIn.attemptLightweightAuthentication();

      // Try to authenticate the user
      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.authenticate();
      } catch (e) {
        // If authentication fails, return the error
        return Left(Failure('Google sign in error: $e'));
      }

      // Check if we have a user after authentication
      if (googleUser == null) {
        return Left(Failure('Authentication failed'));
      }

      // Get authentication tokens
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final result = await _supabase.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
      );

      if (result.session?.user case final User user) {
        return Right(AuthenticatedUser(id: user.id));
      }

      return Left(Failure('Authentication failed'));
    } catch (e) {
      return Left(Failure('Google sign in error: $e'));
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
