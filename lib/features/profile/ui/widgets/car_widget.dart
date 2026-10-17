import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/features/profile/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarWidget extends StatelessWidget {
  final CarModel car;

  const CarWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .circular(24),
        color: AppColors.lightDarkBlue,
        border: .all(color: AppColors.white),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            fit: .cover,
            imageUrl: car.image,
            width: context.screenWidth * 0.25,
            height: context.screenWidth * 0.25,
            errorWidget: (context, url, error) => Icon(Icons.error, color: AppColors.white),
            placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
          ),
        ],
      ),
    );
  }
}
