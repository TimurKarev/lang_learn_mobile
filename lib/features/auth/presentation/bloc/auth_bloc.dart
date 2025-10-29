import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lang_learn_mobile/core/error_handling/ui_error.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

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
      emit(
        UnauthenticatedUser(
          UiError(
            title: 'Error',
            displayType: ErrorDisplayType.toast,
            description: 'Something went wrong',
          ),
        ),
      );
    }
  }

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogleEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    final result = await _authRepository.signInWithGoogle();
    if (result.isLeft) {
      emit(
        UnauthenticatedUser(
          UiError(
            title: 'Не удалось войти',
            displayType: ErrorDisplayType.toast,
            description: 'Попробуйте другой способ или обратитесь в поддержку',
          ),
        ),
      );
    }
  }

  Future<void> _onLogout(
    AuthSingoutEvent event,
    Emitter<ProjectUser> emit,
  ) async {
    await _authRepository.signOut();
  }
}
