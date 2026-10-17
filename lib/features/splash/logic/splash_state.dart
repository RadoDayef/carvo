part of 'splash_cubit.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.loading() = _Loading;

  const factory SplashState.success() = _Success;

  const factory SplashState.failure(String message) = _Failure;
}
