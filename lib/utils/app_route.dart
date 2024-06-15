import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/AddNewTaskScreen/add_new_task_screen.dart';
import 'package:task_manager/view/screens/MainBottomBar/main_bottom_bar.dart';
import 'package:task_manager/view/screens/ProfileScreen/profile_screen.dart';
import 'package:task_manager/view/screens/SplashScreen/splash_screen.dart';

import '../view/screens/auth/ForgetScreen/forget_screen.dart';
import '../view/screens/auth/LoginScreen/login_screen.dart';
import '../view/screens/auth/PinVerificationScreen/pin_verification_screen.dart';
import '../view/screens/auth/ResetPasswordScreen/reset_password_screen.dart';
import '../view/screens/auth/SignUp/signup_screen.dart';

class AppRoute {

  //splash screen
  static const String splashScreen = "/splash_screen";

  //auth part
  static const String loginScreen = "/login_screen";
  static const String forgetScreen = "/forget_screen";
  static const String signupScreen = "/signup_screen";
  static const String pinVerificationScreen = "/pin_verification_screen";
  static const String resetPasswordScreen = "/reset_password_screen";

  //main part
  static const String mainBottomBar = "/main_bottom_bar";
  static const String profileScreen = "/profile_screen";
  static const String addNewTaskScreen = "/add_new_task_screen";

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

      case mainBottomBar:
        widget = const MainBottomBar();
        break;

      case profileScreen:
        widget = const ProfileScreen();
        break;

      case addNewTaskScreen:
        widget = const AddNewTaskScreen();
        break;
    }
    if (widget != null) {
      return MaterialPageRoute(builder: (context) => widget!);
    }

    return null;
  }
}
