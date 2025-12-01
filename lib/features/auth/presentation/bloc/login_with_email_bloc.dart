import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'login_with_email_event.dart';
part 'login_with_email_state.dart';

class LoginWithEmailBloc
    extends Bloc<LoginWithEmailEvent, LoginWithEmailState> {
  final AuthRepository _authRepository;

  LoginWithEmailBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginWithEmailState()) {
    on<LoginEmailChanged>(_onEmailChanged, transformer: _debounceTransformer());
    on<LoginPasswordChanged>(
      _onPasswordChanged,
      transformer: _debounceTransformer(),
    );
    on<LoginSubmitted>(_onSubmitted);
  }

  EventTransformer<T> _debounceTransformer<T>() {
    return (events, mapper) => events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(mapper);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginWithEmailState> emit,
  ) {
    emit(
      state.copyWith(email: event.email, status: LoginWithEmailStatus.initial),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginWithEmailState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        status: LoginWithEmailStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginWithEmailState> emit,
  ) async {
    if (state.email.isEmpty || state.password.isEmpty) return;

    emit(state.copyWith(status: LoginWithEmailStatus.loading));

    final result = await _authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(
          status: LoginWithEmailStatus.failure,
          errorMessage: failure.type.toString(),
        ),
      ),
      ifRight: (user) =>
          emit(state.copyWith(status: LoginWithEmailStatus.success)),
    );
  }
}
