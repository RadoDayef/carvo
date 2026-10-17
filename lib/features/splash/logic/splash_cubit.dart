import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/splash/data/splash_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepo _repo;

  SplashCubit(this._repo) : super(SplashState.loading()) {
    getAndSaveUserData();
  }

  void getAndSaveUserData() async {
    ApiResult<bool> result = await _repo.getUserData();
    result.when(success: (_) => emit(SplashState.success()), failure: (message) => emit(SplashState.failure(message)));
  }
}
