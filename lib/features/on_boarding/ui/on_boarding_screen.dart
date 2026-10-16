import 'package:bingo/bingo.dart';
import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/num_extension.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Spacer(),
                Image.asset(AssetConstants.onboarding, width: context.screenWidth * 0.6),
                24.vGap,
                Text(AppConstants.title, style: theme.textTheme.displaySmall!.copyWith(fontWeight: .w700)),
                12.vGap,
                Text(AppConstants.subtitle, style: theme.textTheme.titleLarge!.copyWith(fontWeight: .w700)),
                12.vGap,
                Text(
                  AppConstants.description,
                  textAlign: .justify,
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: .w500),
                ),
                Spacer(),
                SizedBox(
                  width: .infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Bingo.mark("isFirstTime", false);
                      Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
                    },
                    child: Text("Sign In", style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
