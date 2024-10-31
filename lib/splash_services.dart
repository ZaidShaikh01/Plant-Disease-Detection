import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trail_1/homescreen.dart';
import 'package:trail_1/login.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Login(
                      controller: passwordController,
                    )))));
  }
}
