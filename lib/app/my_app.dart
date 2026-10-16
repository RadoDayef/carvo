import 'package:carvo/app/routing/app_router.dart';
import 'package:carvo/app/theming/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.theme, onGenerateRoute: AppRouter.onGeneratedRoute, debugShowCheckedModeBanner: false);
  }
}
