import 'package:bingo/bingo.dart';
import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepo {
  Future<ApiResult<List<CarModel>>> getUserCars() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("cars").where("ownerUid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      List<CarModel> cars = querySnapshot.docs.map((car) => CarModel.fromJson(car.data(), car.id)).toList();
      await Future.delayed(Duration(seconds: 2));
      return ApiResult.success(cars);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await Bingo.erase("user");
      await Future.delayed(Duration(seconds: 2));
      return ApiResult.success(true);
    } on FirebaseException catch (exception) {
      return ApiResult.failure(exception.message.toString());
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
