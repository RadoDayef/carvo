import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/features/home/data/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeCarWidget extends StatelessWidget {
  final CarModel car;

  const HomeCarWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: AppColors.lightDarkBlue, borderRadius: .circular(16)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: .vertical(top: .circular(16)),
            child: CachedNetworkImage(
              fit: .cover,
              width: .infinity,
              imageUrl: car.image,
              height: context.screenWidth * 0.5,
              errorWidget: (context, url, error) => Icon(Icons.error, color: AppColors.white),
              placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
            ),
          ),
          Padding(
            padding: .all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                double.infinity.hGap,
                RichText(
                  maxLines: 1,
                  overflow: .ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: car.brand,
                        style: theme.textTheme.titleLarge!.copyWith(fontWeight: .bold),
                      ),
                      WidgetSpan(child: 4.hGap),
                      TextSpan(text: "-"),
                      WidgetSpan(child: 4.hGap),
                      TextSpan(text: car.model, style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
                4.vGap,
                Text(car.description, maxLines: 2, overflow: .ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
