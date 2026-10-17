import 'package:carvo/core/shared/logic/visibility_cubit/visibility_cubit.dart';
import 'package:carvo/features/auth/forget_password/data/forget_password_repo.dart';
import 'package:carvo/features/auth/forget_password/logic/forget_password_cubit.dart';
import 'package:carvo/features/auth/sign_in/data/sign_in_repo.dart';
import 'package:carvo/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:carvo/features/auth/sign_up/data/sign_up_repo.dart';
import 'package:carvo/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carvo/features/profile/data/profile_repo.dart';
import 'package:carvo/features/profile/logic/profile_cars_cubit/profile_cars_cubit.dart';
import 'package:carvo/features/splash/data/splash_repo.dart';
import 'package:carvo/features/splash/logic/splash_cubit.dart';
import 'package:get_it/get_it.dart';

class Injection {
  static final GetIt getIt = GetIt.instance;

  static void setUp() {
    /// Repos
    getIt.registerFactory<SignUpRepo>(() => SignUpRepo());
    getIt.registerFactory<SplashRepo>(() => SplashRepo());
    getIt.registerFactory<SignInRepo>(() => SignInRepo());
    getIt.registerFactory<ProfileRepo>(() => ProfileRepo());
    getIt.registerFactory<ForgetPasswordRepo>(() => ForgetPasswordRepo());

    /// Cubits
    getIt.registerFactory<VisibilityCubit>(() => VisibilityCubit());
    getIt.registerLazySingleton<SplashCubit>(() => SplashCubit(getIt<SplashRepo>()));
    getIt.registerLazySingleton<SignUpCubit>(() => SignUpCubit(getIt<SignUpRepo>()));
    getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<SignInRepo>()));
    getIt.registerLazySingleton<ProfileCarsCubit>(() => ProfileCarsCubit(getIt<ProfileRepo>()));
    getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()));
  }
}
