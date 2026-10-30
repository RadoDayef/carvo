import 'dart:io';

import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/features/add_car/logic/add_car_cubit/add_car_cubit.dart';
import 'package:carvo/features/add_car/logic/add_car_image_cubit/add_car_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AddCarCubit cubit = context.read<AddCarCubit>();
    final AddCarImageCubit imageCubit = context.read<AddCarImageCubit>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add Car")),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: .onDrag,
          padding: .only(top: 24, right: 24, left: 24, bottom: context.mq.viewInsets.bottom + 24),
          child: Column(
            children: [
              InkWell(
                borderRadius: .circular(16),
                onTap: imageCubit.addImage,
                child: BlocBuilder<AddCarImageCubit, File?>(
                  builder: (context, image) {
                    return Container(
                      width: .infinity,
                      height: context.screenWidth * 0.6,
                      decoration: BoxDecoration(color: AppColors.lightDarkBlue, borderRadius: .circular(16)),
                      child: image == null
                          ? Icon(Icons.photo_camera_back, size: 48)
                          : ClipRRect(
                              borderRadius: .circular(16),
                              child: Image.file(image, fit: .cover),
                            ),
                    );
                  },
                ),
              ),
              24.vGap,
              TextFormField(
                cursorColor: AppColors.white,
                controller: cubit.brandController,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(labelText: "Brand", prefixIcon: Icon(Icons.merge_type_rounded)),
              ),
              24.vGap,
              TextFormField(
                cursorColor: AppColors.white,
                controller: cubit.modelController,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(labelText: "Model", prefixIcon: Icon(Icons.model_training_rounded)),
              ),
              24.vGap,
              TextFormField(
                minLines: 4,
                maxLines: 5,
                cursorColor: AppColors.white,
                controller: cubit.descriptionController,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(labelText: "Description", prefixIcon: Icon(Icons.text_fields)),
              ),
              48.vGap,
              SizedBox(
                width: .infinity,
                child: BlocConsumer<AddCarCubit, AddCarState>(
                  listener: (context, state) {
                    state.whenOrNull(success: () => Navigator.of(context).pop(true), failure: (message) => message.showToast);
                  },
                  builder: (context, state) {
                    return BlocBuilder<AddCarImageCubit, File?>(
                      builder: (context, image) {
                        return ElevatedButton(
                          onPressed: state.maybeWhen(
                            orElse: () =>
                                () => cubit.addCar(image),
                            loading: () => () {},
                          ),
                          child: state.maybeWhen(
                            orElse: () => Text(
                              "Upload Car",
                              style: theme.textTheme.titleMedium!.copyWith(fontWeight: .bold, color: AppColors.darkBlue),
                            ),
                            loading: () => LoadingAnimationWidget.threeRotatingDots(color: AppColors.darkBlue, size: 24),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
