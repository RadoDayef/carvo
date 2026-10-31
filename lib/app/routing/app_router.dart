import 'package:carvo/core/injection/injection.dart';
import 'package:carvo/core/shared/logic/visibility_cubit/visibility_cubit.dart';
import 'package:carvo/features/add_car/logic/add_car_cubit/add_car_cubit.dart';
import 'package:carvo/features/add_car/logic/add_car_image_cubit/add_car_image_cubit.dart';
import 'package:carvo/features/add_car/ui/add_car_screen.dart';
import 'package:carvo/features/auth/forget_password/logic/forget_password_cubit.dart';
import 'package:carvo/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:carvo/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carvo/features/details/ui/details_screen.dart';
import 'package:carvo/features/home/logic/home_cubit.dart';
import 'package:carvo/features/profile/logic/profile_cars_cubit/profile_cars_cubit.dart';
import 'package:carvo/features/profile/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:carvo/features/profile/ui/profile_screen.dart';
import 'package:carvo/features/splash/logic/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/forget_password/ui/forget_password_screen.dart';
import '../../features/auth/sign_in/ui/sign_in_screen.dart';
import '../../features/auth/sign_up/ui/sign_up_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../gate.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.gate:
        return MaterialPageRoute(builder: (context) => Gate());
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(create: (context) => Injection.getIt<HomeCubit>(), child: HomeScreen()),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injection.getIt<SignInCubit>()),
              BlocProvider(create: (context) => Injection.getIt<VisibilityCubit>()),
            ],
            child: SignInScreen(),
          ),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injection.getIt<SignUpCubit>()),
              BlocProvider(create: (context) => Injection.getIt<VisibilityCubit>()),
            ],
            child: SignUpScreen(),
          ),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(create: (context) => Injection.getIt<SplashCubit>(), child: SplashScreen()),
        );
      case AppRoutes.addCar:
        return MaterialPageRoute<bool?>(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injection.getIt<AddCarCubit>()),
              BlocProvider(create: (context) => Injection.getIt<AddCarImageCubit>()),
            ],
            child: AddCarScreen(),
          ),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injection.getIt<SignOutCubit>()),
              BlocProvider(create: (context) => Injection.getIt<ProfileCarsCubit>()),
            ],
            child: ProfileScreen(),
          ),
        );
      case AppRoutes.details:
        return MaterialPageRoute(builder: (context) => DetailsScreen());
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(create: (context) => Injection.getIt<ForgetPasswordCubit>(), child: ForgetPasswordScreen()),
        );
      default:
        return MaterialPageRoute(builder: (context) => Scaffold());
    }
  }
}
