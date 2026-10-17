import 'package:bingo/bingo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/features/splash/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final UserModel user = Bingo.call<UserModel>("user")!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(24),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.profile);
                    },
                    child: ClipRRect(
                      borderRadius: .circular(999),
                      child: CachedNetworkImage(
                        fit: .cover,
                        imageUrl: user.image,
                        width: context.screenWidth * 0.15,
                        height: context.screenWidth * 0.15,
                        errorWidget: (context, url, error) => Icon(Icons.error, color: AppColors.white),
                        placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.white, size: 24),
                      ),
                    ),
                  ),
                  16.hGap,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text("Hi", style: theme.textTheme.titleMedium),
                        Text("${user.firstName} ${user.lastName}", style: theme.textTheme.titleMedium!.copyWith(fontWeight: .bold)),
                      ],
                    ),
                  ),
                  16.hGap,
                  Icon(Icons.search, color: AppColors.white),
                ],
              ),
              24.vGap,
              Expanded(
                child: ListView.separated(
                  itemCount: 15,
                  separatorBuilder: (_, _) => 16.vGap,
                  itemBuilder: (_, int index) {
                    return Container(height: 50, color: Colors.blue);
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
