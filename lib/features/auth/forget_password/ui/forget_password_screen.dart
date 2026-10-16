import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/constants/asset_constants.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/features/auth/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ForgetPasswordCubit cubit = context.read<ForgetPasswordCubit>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: .all(24),
            child: Column(
              children: [
                Image.asset(AssetConstants.logo, width: context.screenWidth * 0.6),
                Align(
                  alignment: .centerLeft,
                  child: Text("Forget Password", style: theme.textTheme.titleLarge!.copyWith(fontWeight: .bold)),
                ),
                24.vGap,
                Form(
                  key: cubit.formKey,
                  child: TextFormField(
                    keyboardType: .emailAddress,
                    cursorColor: AppColors.white,
                    controller: cubit.emailController,
                    autovalidateMode: .onUserInteraction,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.email_rounded), labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email can't be empty";
                      } else if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                32.vGap,
                SizedBox(
                  width: .infinity,
                  child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      state.whenOrNull(success: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signIn), failure: (message) => message.showToast);
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.maybeWhen(orElse: () => cubit.forgetPassword, loading: () => () {}),
                        child: state.maybeWhen(
                          orElse: () => Text(
                            "Send Email",
                            style: theme.textTheme.titleMedium!.copyWith(fontWeight: .bold, color: AppColors.darkBlue),
                          ),
                          loading: () => LoadingAnimationWidget.threeRotatingDots(color: AppColors.darkBlue, size: 24),
                        ),
                      );
                    },
                  ),
                ),
                24.vGap,
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(text: "Remembered My Password "),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signIn),
                          child: Text("Sign In?", style: theme.textTheme.bodySmall!.copyWith(fontWeight: .bold)),
                        ),
                      ),
                    ],
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
