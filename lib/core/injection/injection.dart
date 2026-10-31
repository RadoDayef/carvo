import 'package:carvo/core/shared/logic/visibility_cubit/visibility_cubit.dart';
import 'package:carvo/features/add_car/data/add_car_repo.dart';
import 'package:carvo/features/add_car/logic/add_car_cubit/add_car_cubit.dart';
import 'package:carvo/features/add_car/logic/add_car_image_cubit/add_car_image_cubit.dart';
import 'package:carvo/features/auth/forget_password/data/forget_password_repo.dart';
import 'package:carvo/features/auth/forget_password/logic/forget_password_cubit.dart';
import 'package:carvo/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:carvo/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:carvo/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:carvo/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carvo/features/home/data/home_repo.dart';
import 'package:carvo/features/home/logic/home_cubit.dart';
import 'package:carvo/features/profile/data/profile_repo.dart';
import 'package:carvo/features/profile/logic/profile_cars_cubit/profile_cars_cubit.dart';
import 'package:carvo/features/profile/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:carvo/features/splash/data/splash_repo.dart';
import 'package:carvo/features/splash/logic/splash_cubit.dart';
import 'package:get_it/get_it.dart';

class Injection {
  static final GetIt getIt = GetIt.instance;

  static void setUp() {
    /// Repos
    getIt.registerFactory<HomeRepo>(() => HomeRepo());
    getIt.registerFactory<AddCarRepo>(() => AddCarRepo());
    getIt.registerFactory<SignUpRepo>(() => SignUpRepo());
    getIt.registerFactory<SplashRepo>(() => SplashRepo());
    getIt.registerFactory<SignInRepo>(() => SignInRepo());
    getIt.registerFactory<ProfileRepo>(() => ProfileRepo());
    getIt.registerFactory<ForgetPasswordRepo>(() => ForgetPasswordRepo());

    /// Cubits
    getIt.registerFactory<VisibilityCubit>(() => VisibilityCubit());
    getIt.registerFactory<AddCarImageCubit>(() => AddCarImageCubit());
    getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
    getIt.registerFactory<AddCarCubit>(() => AddCarCubit(getIt<AddCarRepo>()));
    getIt.registerLazySingleton<SplashCubit>(() => SplashCubit(getIt<SplashRepo>()));
    getIt.registerLazySingleton<SignUpCubit>(() => SignUpCubit(getIt<SignUpRepo>()));
    getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<SignInRepo>()));
    getIt.registerLazySingleton<SignOutCubit>(() => SignOutCubit(getIt<ProfileRepo>()));
    getIt.registerLazySingleton<ProfileCarsCubit>(() => ProfileCarsCubit(getIt<ProfileRepo>()));
    getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()));
  }
}
