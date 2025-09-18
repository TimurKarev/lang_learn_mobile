import 'package:bloc/bloc.dart';

import 'package:lang_learn_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required OnboardingRepository onboardingRepository})
    : _onboardingRepository = onboardingRepository,
      super(const SplashInitial()) {
    on<SplashInitialEvent>(_onInitial);
  }

  final OnboardingRepository _onboardingRepository;

  Future<void> _onInitial(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    final isFirst = await _onboardingRepository.isFirstLaunch();

    emit(SplashCheckComplete(isFirst: isFirst));
  }
}
