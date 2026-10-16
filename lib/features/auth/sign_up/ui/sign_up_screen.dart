import 'package:carvo/app/routing/app_routes.dart';
import 'package:carvo/app/theming/app_colors.dart';
import 'package:carvo/core/constants/asset_constants.dart';
import 'package:carvo/core/extensions/context_extension.dart';
import 'package:carvo/core/extensions/num_extension.dart';
import 'package:carvo/core/extensions/string_extension.dart';
import 'package:carvo/core/shared/logic/visibility_cubit/visibility_cubit.dart';
import 'package:carvo/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SignUpCubit cubit = context.read<SignUpCubit>();
    final VisibilityCubit visibilityCubit = context.read<VisibilityCubit>();
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
                  child: Text("Sign Up", style: theme.textTheme.titleLarge!.copyWith(fontWeight: .bold)),
                ),
                24.vGap,
                Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: .name,
                              cursorColor: AppColors.white,
                              autovalidateMode: .onUserInteraction,
                              controller: cubit.firstNameController,
                              onTapOutside: (_) => FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(prefixIcon: Icon(Icons.person), labelText: "First Name"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "First Name can't be empty";
                                } else if (value.length > 18) {
                                  return "First Name can't be more than 18 characters";
                                } else if (value.length < 4) {
                                  return "First Name can't be less than 4 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                          24.hGap,
                          Expanded(
                            child: TextFormField(
                              keyboardType: .name,
                              cursorColor: AppColors.white,
                              controller: cubit.lastNameController,
                              autovalidateMode: .onUserInteraction,
                              onTapOutside: (_) => FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(labelText: "Last Name"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Last Name can't be empty";
                                } else if (value.length > 18) {
                                  return "Last Name can't be more than 18 characters";
                                } else if (value.length < 4) {
                                  return "Last Name can't be less than 4 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      32.vGap,
                      TextFormField(
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
                      32.vGap,
                      BlocBuilder<VisibilityCubit, bool>(
                        builder: (context, isVisible) {
                          return TextFormField(
                            obscureText: isVisible,
                            cursorColor: AppColors.white,
                            keyboardType: .visiblePassword,
                            controller: cubit.passwordController,
                            autovalidateMode: .onUserInteraction,
                            onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_rounded),
                              suffixIcon: InkWell(onTap: visibilityCubit.toggleVisibility, child: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password can't be empty";
                              } else if (value.length > 24) {
                                return "Password can't be more than 24 characters";
                              } else if (value.length < 8) {
                                return "Password can't be less than 8 characters";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                32.vGap,
                SizedBox(
                  width: .infinity,
                  child: BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      state.whenOrNull(success: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signIn), failure: (message) => message.showToast);
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.maybeWhen(orElse: () => cubit.signUp, loading: () => () {}),
                        child: state.maybeWhen(
                          orElse: () => Text(
                            "Sign Up",
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
                      TextSpan(text: "Already have an account "),
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
