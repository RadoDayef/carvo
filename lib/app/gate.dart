import 'package:bingo/bingo.dart';
import 'package:carvo/core/injection/injection.dart';
import 'package:carvo/core/shared/logic/visibility_cubit/visibility_cubit.dart';
import 'package:carvo/features/auth/sign_in/logic/sign_in_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/sign_in/ui/sign_in_screen.dart';
import '../features/on_boarding/ui/on_boarding_screen.dart';
import '../features/splash/ui/splash_screen.dart';

class Gate extends StatelessWidget {
  const Gate({super.key});

  @override
  Widget build(BuildContext context) {
    if (Bingo.call<bool>("isFirstTime") ?? true) {
      return OnBoardingScreen();
    } else if (FirebaseAuth.instance.currentUser != null) {
      return SplashScreen();
    } else {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => Injection.getIt<SignInCubit>()),
          BlocProvider(create: (context) => Injection.getIt<VisibilityCubit>()),
        ],
        child: SignInScreen(),
      );
    }
  }
}
