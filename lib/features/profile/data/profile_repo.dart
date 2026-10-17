import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/profile/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepo {
  Future<ApiResult<List<CarModel>>> getUserCars() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("cars").where("ownerUid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      List<CarModel> cars = querySnapshot.docs.map((car) => CarModel.fromJson(car.data())).toList();
      await Future.delayed(Duration(seconds: 4));
      return ApiResult.success(cars);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
