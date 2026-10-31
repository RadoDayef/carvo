import 'dart:io';

import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    try {
      final String path = image.path.split("/").last;
      final String response = await Supabase.instance.client.storage.from("carImages").upload(path, image, fileOptions: FileOptions(upsert: true));
      final String publicUrl = Supabase.instance.client.storage.from("carImages").getPublicUrl(response);
      return ApiResult.success(publicUrl.filterUrl);
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}

/// Add Car To Firebase
///   - Brand
///   - Model
///   - Image
///   - Owner UID
///   - Description

/// Upload Car Image To Supabase And Get Public URL
