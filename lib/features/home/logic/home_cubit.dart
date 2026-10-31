import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/home/data/home_repo.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _repo;

  HomeCubit(this._repo) : super(HomeState.loading()) {
    getCars();
  }

  void getCars() async {
    ApiResult<List<CarModel>> result = await _repo.getOtherUsersCars();
    result.when(success: (cars) => emit(HomeState.success(cars)), failure: (message) => emit(HomeState.failure(message)));
  }
}
