import 'package:carvo/core/network/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordRepo {
  Future<ApiResult<bool>> sedResetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return ApiResult.success(true);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
