import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lang_learn_mobile/features/auth/domain/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged, transformer: _debounce());
    on<RegisterEmailChanged>(_onEmailChanged, transformer: _debounce());
    on<RegisterPasswordChanged>(_onPasswordChanged, transformer: _debounce());
    on<RegisterConfirmPasswordChanged>(
      _onConfirmPasswordChanged,
      transformer: _debounce(),
    );
    on<RegisterTermsChanged>(_onTermsChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  EventTransformer<E> _debounce<E>() {
    return (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper);
    };
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name, status: RegisterStatus.initial));
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email, status: RegisterStatus.initial));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(password: event.password, status: RegisterStatus.initial),
    );
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        status: RegisterStatus.initial,
      ),
    );
  }

  void _onTermsChanged(
    RegisterTermsChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        termsAccepted: event.accepted,
        status: RegisterStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Please fill in all fields',
        ),
      );
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Passwords do not match',
        ),
      );
      return;
    }

    if (!state.termsAccepted) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Please accept the Terms of Service',
        ),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await _authRepository.signUpWithEmailAndPassword(
      email: state.email,
      password: state.password,
      fullName: state.name,
    );

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: failure.technicalMessage,
        ),
      ),
      ifRight: (user) => emit(state.copyWith(status: RegisterStatus.success)),
    );
  }
}
