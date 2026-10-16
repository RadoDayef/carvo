import 'package:carvo/core/network/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRepo {
  Future<ApiResult<bool>> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return ApiResult.success(true);
      } else {
        return ApiResult.failure("Something went wrong");
      }
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
