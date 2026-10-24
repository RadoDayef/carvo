import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/profile/data/models/car_model.dart';
import 'package:carvo/features/profile/data/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_cars_cubit.freezed.dart';
part 'profile_cars_state.dart';

class ProfileCarsCubit extends Cubit<ProfileCarsState> {
  final ProfileRepo _repo;

  ProfileCarsCubit(this._repo) : super(ProfileCarsState.loading()) {
    getProfileCars();
  }

  void getProfileCars() async {
    emit(ProfileCarsState.loading());
    ApiResult<List<CarModel>> result = await _repo.getUserCars();
    result.when(success: (data) => emit(ProfileCarsState.success(data)), failure: (message) => emit(ProfileCarsState.failure(message)));
  }
}
