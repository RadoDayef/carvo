import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _repo;

  SignUpCubit(this._repo) : super(SignUpState.initial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  void signUp() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpState.loading());
      ApiResult<bool> result = await _repo.signUpWithEmailAndPassword(emailController.text, passwordController.text, firstName: firstNameController.text, lastName: lastNameController.text);
      result.when(success: (data) => emit(SignUpState.success()), failure: (message) => emit(SignUpState.failure(message)));
    }
  }
}
