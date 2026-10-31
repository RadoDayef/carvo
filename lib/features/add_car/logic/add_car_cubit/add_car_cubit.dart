import 'dart:io';

import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/core/network/api_result.dart';
import 'package:carvo/features/add_car/data/add_car_repo.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_car_cubit.freezed.dart';
part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  final AddCarRepo _repo;

  AddCarCubit(this._repo) : super(AddCarState.initial());

  TextEditingController modelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addCar(File? image) async {
    if (image != null) {
      emit(AddCarState.loading());
      CarModel car = CarModel(uid: "", brand: brandController.text, image: "", model: modelController.text, description: descriptionController.text, ownerUid: FirebaseAuth.instance.currentUser!.uid);
      ApiResult<bool> result = await _repo.createNewCar(car, image);
      result.when(success: (_) => emit(AddCarState.success()), failure: (message) => emit(AddCarState.failure(message)));
    } else {
      "Image can't be null".showToast;
    }
  }
}
