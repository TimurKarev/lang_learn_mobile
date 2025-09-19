import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashCheckComplete extends SplashState {
  const SplashCheckComplete({required this.isFirst});

  final bool isFirst;

  @override
  List<Object?> get props => [isFirst];
}
