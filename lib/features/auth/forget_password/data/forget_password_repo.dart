import 'package:carvo/core/network/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordRepo {
  Future<ApiResult<bool>> sedResetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Future.delayed(Duration(seconds: 4));
      return ApiResult.success(true);
    } on FirebaseException catch (exception) {
      return ApiResult.failure(exception.message.toString());
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
