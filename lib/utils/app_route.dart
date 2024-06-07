import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/SplashScreen/splash_screen.dart';

import '../view/screens/auth/ForgetScreen/forget_screen.dart';
import '../view/screens/auth/LoginScreen/login_screen.dart';
import '../view/screens/auth/PinVerificationScreen/pin_verification_screen.dart';
import '../view/screens/auth/ResetPasswordScreen/reset_password_screen.dart';
import '../view/screens/auth/SignUp/signup_screen.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String forgetScreen = "/forget_screen";
  static const String signupScreen = "/signup_screen";
  static const String pinVerificationScreen = "/pin_verification_screen";
  static const String resetPasswordScreen = "/reset_password_screen";

  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    Widget? widget;
    switch (settings.name) {
      case splashScreen:
        widget = const SplashScreen();
        break;

      case loginScreen:
        widget = const LoginScreen();
        break;

      case forgetScreen:
        widget = const ForgetScreen();
        break;

      case signupScreen:
        widget = const SignupScreen();
        break;

      case pinVerificationScreen:
        widget = const PinVerificationScreen();
        break;

      case resetPasswordScreen:
        widget = const ResetPasswordScreen();
        break;
    }
    if (widget != null) {
      return MaterialPageRoute(builder: (context) => widget!);
    }

    return null;
  }
}
