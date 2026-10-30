import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/features/profile/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarWidget extends StatelessWidget {
  final CarModel car;

  const CarWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.details, arguments: car),
      child: Container(
        padding: .all(16),
        decoration: BoxDecoration(
          borderRadius: .circular(24),
          color: AppColors.lightDarkBlue,
          border: .all(color: AppColors.white),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: .circular(12),
              child: CachedNetworkImage(
                fit: .cover,
                imageUrl: car.image,
                width: context.screenWidth * 0.15,
                height: context.screenWidth * 0.15,
                errorWidget: (context, url, error) => Icon(Icons.error, color: AppColors.white),
                placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
              ),
            ),
            16.hGap,
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(car.brand, style: theme.textTheme.titleLarge!.copyWith(fontWeight: .bold)),
                4.hGap,
                Text(car.model, style: theme.textTheme.titleMedium),
                // 6.hGap,
                // Text(
                //   car.description,
                //   maxLines: 2,
                //   overflow: .ellipsis,
                //   style: theme.textTheme.titleSmall!.copyWith(color: AppColors.white.withAlpha(150)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
