import 'package:carvo/core/network/api_result.dart';

class SignUpRepo {
  Future<ApiResult<bool>> signUpWithEmailAndPassword(String email, String password, {required String firstName, required String lastName}) async {
    try {
      return ApiResult.success(true);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
