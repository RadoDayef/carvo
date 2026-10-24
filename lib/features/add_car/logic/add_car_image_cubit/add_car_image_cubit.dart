import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCarImageCubit extends Cubit<File?> {
  AddCarImageCubit() : super(null);

  void addImage() async {
    ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: .gallery);
    File? image;
    if (imageFile?.path != null) {
      image = File(imageFile!.path);
    }
    emit(image);
  }
}
