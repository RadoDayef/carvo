part of 'add_car_cubit.dart';

@freezed
class AddCarState with _$AddCarState {
  const factory AddCarState.initial() = _Initial;

  const factory AddCarState.loading() = _Loading;

  const factory AddCarState.success() = _Success;

  const factory AddCarState.failure(String message) = _Failure;
}
