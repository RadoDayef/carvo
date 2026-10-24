import 'dart:io';

import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/profile/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCarRepo {
  Future<ApiResult<bool>> createNewCar(CarModel car, File image) async {
    try {
      Map<String, dynamic> carMap = car.toJson();
      ApiResult<String> imageResult = await uploadCarImage(image);
      return await imageResult.when(
        success: (url) async {
          carMap["image"] = url;
          await FirebaseFirestore.instance.collection("cars").doc().set(carMap);
          await Future.delayed(Duration(seconds: 2));
          return ApiResult.success(true);
        },
        failure: (message) => ApiResult.failure(message),
      );
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }

  Future<ApiResult<String>> uploadCarImage(File image) async {
    try {} catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
