import 'package:bingo/bingo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/features/profile/logic/profile_cars_cubit/profile_cars_cubit.dart';
import 'package:carvo/features/profile/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:carvo/features/profile/ui/widgets/profile_car_widget.dart';
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
    final SignOutCubit signOutCubit = context.read<SignOutCubit>();
    final ProfileCarsCubit cubit = context.read<ProfileCarsCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Profile"),
        actions: [
          BlocConsumer<SignOutCubit, SignOutState>(
            listener: (context, state) {
              state.whenOrNull(success: () => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false), failure: (message) => message.showToast);
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
                orElse: () {
                  return InkWell(
                    onTap: signOutCubit.signOut,
                    child: Icon(Icons.logout, color: AppColors.white),
                  );
                },
              );
            },
          ),
          12.hGap,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? addResult = await Navigator.of(context).pushNamed(AppRoutes.addCar);
          if (addResult ?? false) {
            cubit.getProfileCars();
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: .all(24),
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
                          return ListView.separated(itemCount: cars.length, separatorBuilder: (_, _) => 16.vGap, itemBuilder: (_, int index) => ProfileCarWidget(cars[index]));
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
