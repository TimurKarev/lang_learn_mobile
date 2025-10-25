enum Paths {
  splash(path: '/', name: 'splash'),
  onboarding(path: 'onboarding', name: 'onboarding'),
  login(path: 'login', name: 'login'),
  termsOfUse(path: '/terms-of-use', name: 'terms-of-use'),
  privacyPolicy(path: '/privacy-policy', name: 'privacy-policy'),

  home(path: '/home', name: 'home'),
  vocabularyDashboard(
    path: 'vocabulary-dashboard',
    name: 'vocabulary-dashboard',
  ),
  vocabularyChallenge(
    path: '/vocabulary-challenge',
    name: 'vocabulary-challenge',
  ),
  vocabularyChallengeHistory(
    path: '/vocabulary-challenge-history',
    name: 'vocabulary-challenge-history',
  ),
  vocabularyChallengeInformation(
    path: '/vocabulary-challenge-information',
    name: 'vocabulary-challenge-information',
  ),
  vocabularyChallengeSettings(
    path: 'vocabulary-challenge-settings',
    name: 'vocabulary-challenge-settings',
  ),

  nothig(path: '/nothig', name: 'nothig'),
  error(path: '/error', name: 'error');

  const Paths({required this.path, required this.name});

  final String path;
  final String name;
}
