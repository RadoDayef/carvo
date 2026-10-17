import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo _repo;

  SignInCubit(this._repo) : super(SignInState.initial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn() async {
    if (formKey.currentState!.validate()) {
      emit(SignInState.loading());
      ApiResult<bool> result = await _repo.signInWithEmailAndPassword(emailController.text, passwordController.text);
      result.when(success: (data) => emit(SignInState.success()), failure: (message) => emit(SignInState.failure(message)));
    }
  }
}
