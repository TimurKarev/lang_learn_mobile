import 'dart:async';

abstract class OnboardingRepository {
  Future<bool> isFirstLaunch();
  Future<void> completeOnboarding();
}

class MockOnboardingRepository implements OnboardingRepository {
  @override
  Future<bool> isFirstLaunch() async {
    // Always return true for testing first launch flow
    return true;
  }

  @override
  Future<void> completeOnboarding() async {
    // Mock: no real persistence, just complete
  }
}
