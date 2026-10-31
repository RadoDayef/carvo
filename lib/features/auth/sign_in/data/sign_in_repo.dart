import 'package:carvo/core/network/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRepo {
  Future<ApiResult<bool>> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        if (credential.user!.emailVerified) {
          await Future.delayed(Duration(seconds: 2));
          return ApiResult.success(true);
        } else {
          await FirebaseAuth.instance.signOut();
          return ApiResult.failure("Email not verified");
        }
      } else {
        return ApiResult.failure("Something went wrong");
      }
    } on FirebaseException catch (exception) {
      return ApiResult.failure(exception.message.toString());
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
