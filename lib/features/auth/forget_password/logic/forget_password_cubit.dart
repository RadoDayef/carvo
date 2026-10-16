import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/auth/forget_password/data/forget_password_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_cubit.freezed.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _repo;

  ForgetPasswordCubit(this._repo) : super(ForgetPasswordState.initial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  void forgetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(ForgetPasswordState.loading());
      await Future.delayed(Duration(seconds: 4));
      ApiResult<bool> result = await _repo.sedResetPasswordEmail(emailController.text);
      result.when(success: (_) => emit(ForgetPasswordState.success()), failure: (message) => emit(ForgetPasswordState.failure(message)));
    }
  }
}
