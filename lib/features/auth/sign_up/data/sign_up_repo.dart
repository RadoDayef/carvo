import 'package:carvo/core/network/api_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepo {
  Future<ApiResult<bool>> signUpWithEmailAndPassword(String email, String password, {required String firstName, required String lastName}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        credential.user!.sendEmailVerification();
        await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set({"uid": credential.user!.uid, "email": email, "firstName": firstName, "lastName": lastName});
        FirebaseAuth.instance.signOut();
        await Future.delayed(Duration(seconds: 4));
        return ApiResult.success(true);
      } else {
        return ApiResult.failure("Couldn't Sign Up With Email & Password");
      }
    } on FirebaseException catch (exception) {
      return ApiResult.failure(exception.message.toString());
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
