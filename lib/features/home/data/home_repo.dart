import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {
  Future<ApiResult<List<CarModel>>> getOtherUsersCars() async {
    try {
      QuerySnapshot<Map<String, dynamic>> otherUsersCarsDocs = await FirebaseFirestore.instance.collection("cars").where("ownerUid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      List<CarModel> otherUsersCars = otherUsersCarsDocs.docs.map((car) => CarModel.fromJson(car.data(), car.id)).toList();
      await Future.delayed(Duration(seconds: 2));
      return ApiResult.success(otherUsersCars);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
