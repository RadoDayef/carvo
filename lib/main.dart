import 'package:bingo/bingo.dart';
import 'package:carvo/core/injection/injection.dart';
import 'package:carvo/features/splash/data/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/my_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bingo.setup();
  Injection.setUp();
  Bingo.register<UserModel>((user) => UserModel.fromJson(user));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(url: "https://aghmdeqnsrtxbloajewd.supabase.co", publishableKey: "sb_publishable_9lhiDRKpUufNXwLj_bv8iw_Nsbzt8St");
  runApp(MyApp());
}
