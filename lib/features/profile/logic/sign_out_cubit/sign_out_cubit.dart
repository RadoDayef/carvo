import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/profile/data/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_out_cubit.freezed.dart';
part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final ProfileRepo _repo;

  SignOutCubit(this._repo) : super(SignOutState.initial());

  void signOut() async {
    emit(SignOutState.loading());
    ApiResult<bool> result = await _repo.signOut();
    result.when(success: (_) => emit(SignOutState.success()), failure: (message) => emit(SignOutState.failure(message)));
  }
}
