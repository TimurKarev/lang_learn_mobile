import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// TODO: create repo and return app ProjectUser from here
class AuthBloc extends Bloc<AuthEvent, ProjectUser> with ChangeNotifier {
  AuthBloc() : super(UnauthenticatedUser()) {
    on<AuthInitialEvent>(_onAuthInitialEvent);
    on<AuthSignInAnonymouslyEvent>(_onSignInAnonymously);
    on<AuthLogoutEvent>(_onLogout);
  }

  GoTrueClient get _supabase => Supabase.instance.client.auth;

  @override
  void emit(ProjectUser state) {
    // ignore: invalid_use_of_visible_for_testing_member
    super.emit(state);
    notifyListeners();
  }

  Future<void> _onAuthInitialEvent(
    AuthInitialEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    await emit.forEach(
      _supabase.onAuthStateChange,
      onData: (data) {
        if (data.session?.user case final User user) {
          return AuthenticatedUser(id: user.id);
        }
        return UnauthenticatedUser();
      },
    );
  }

  Future<void> _onSignInAnonymously(
    AuthSignInAnonymouslyEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    try {
      final response = await _supabase.signInAnonymously();
      if (response.user != null) {
        emit(AuthenticatedUser(id: response.user!.id));
      } else {
        emit(UnauthenticatedUser());
      }
    } catch (e) {
      emit(UnauthenticatedUser());
    }
  }

  Future<void> _onLogout(
    AuthLogoutEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    await _supabase.signOut();
  }
}
