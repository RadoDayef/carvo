import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/constants/asset_constants.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/features/splash/logic/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              state.whenOrNull(success: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home));
            },
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Spacer(),
                Image.asset(AssetConstants.logo, width: context.screenWidth * 0.6),
                Spacer(),
                LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
