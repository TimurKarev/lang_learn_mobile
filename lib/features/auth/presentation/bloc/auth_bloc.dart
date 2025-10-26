import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// TODO: create error scaffold messenger
class AuthBloc extends Bloc<AuthEvent, ProjectUser> with ChangeNotifier {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(UnauthenticatedUser()) {
    on<AuthInitialEvent>(_onAuthInitialEvent);
    on<AuthSignInAnonymouslyEvent>(_onSignInAnonymously);
    on<AuthSignInWithGoogleEvent>(_onSignInWithGoogle);
    on<AuthSingoutEvent>(_onLogout);
  }

  final AuthRepository _authRepository;

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
    await emit.forEach<ProjectUser>(
      _authRepository.authStateChange(),
      onData: (data) => data,
    );
  }

  Future<void> _onSignInAnonymously(
    AuthSignInAnonymouslyEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    try {
      await _authRepository.signInAnonymously();
    } catch (e) {
      emit(UnauthenticatedUser());
    }
  }

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogleEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      emit(UnauthenticatedUser());
    }
  }

  Future<void> _onLogout(
    AuthSingoutEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    await _authRepository.signOut();
  }
}
