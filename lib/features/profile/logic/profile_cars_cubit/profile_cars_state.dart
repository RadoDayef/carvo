part of 'profile_cars_cubit.dart';

@freezed
class ProfileCarsState with _$ProfileCarsState {
  const factory ProfileCarsState.loading() = _Loading;

  const factory ProfileCarsState.success(List<CarModel> cars) = _Success;

  const factory ProfileCarsState.failure(String message) = _Failure;
}
