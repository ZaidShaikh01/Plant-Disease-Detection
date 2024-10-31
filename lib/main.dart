import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trail_1/signup.dart';
import 'package:trail_1/splashscreen.dart';
import 'homescreen.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SplashScreen()));
}
