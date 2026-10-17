import 'package:bingo/bingo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/features/profile/logic/profile_cars_cubit/profile_cars_cubit.dart';
import 'package:carvo/features/profile/ui/widgets/car_widget.dart';
import 'package:carvo/features/splash/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final UserModel user = Bingo.call<UserModel>("user")!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ClipRRect(
                borderRadius: .circular(999),
                child: CachedNetworkImage(
                  fit: .cover,
                  imageUrl: user.image,
                  width: context.screenWidth * 0.33,
                  height: context.screenWidth * 0.33,
                  errorWidget: (context, url, error) => Icon(Icons.error, color: AppColors.white),
                  placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
                ),
              ),
              16.vGap,
              Text("${user.firstName} ${user.lastName}", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: .bold)),
              Divider(height: 50, indent: context.screenWidth * 0.15, endIndent: context.screenWidth * 0.15, color: AppColors.white.withAlpha(150)),
              Expanded(
                child: BlocBuilder<ProfileCarsCubit, ProfileCarsState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => Center(child: LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 32)),
                      success: (cars) {
                        if (cars.isNotEmpty) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: cars.length,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (_, _) => 16.vGap,
                            itemBuilder: (_, int index) => CarWidget(cars[index]),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: .center,
                            children: [
                              Icon(Icons.car_crash, color: AppColors.white, size: 48),
                              8.vGap,
                              Text("No Cars Found", style: theme.textTheme.titleLarge),
                            ],
                          );
                        }
                      },
                      failure: (message) {
                        return Column(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(Icons.warning_rounded, color: AppColors.white, size: 48),
                            8.vGap,
                            Text(message, style: theme.textTheme.titleLarge),
                          ],
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
