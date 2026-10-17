import 'package:bingo/bingo.dart';
import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/splash/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashRepo {
  Future<ApiResult<bool>> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (userDoc.exists) {
        UserModel user = UserModel.fromJson(userDoc.data()!);
        await Bingo.mark("user", user);
        await Future.delayed(Duration(seconds: 4));
        return ApiResult.success(true);
      } else {
        return ApiResult.failure("User Not Found");
      }
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
