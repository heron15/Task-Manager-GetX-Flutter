import 'package:flutter/cupertino.dart';

import '../../utils/app_route.dart';

class OnTapAction {

  //auth part
  static void onTapGoForgotPasswordScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.forgetScreen);
  }

  static void onTapGoSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.signupScreen);
  }

  static void onTapGoPinVerificationScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.pinVerificationScreen);
  }

  static void onTapGoResetPasswordScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.resetPasswordScreen);
  }

  //main part
  static void onTapGoMainBottomBar(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.mainBottomBar);
  }

  static void onTapGoProfileScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.profileScreen);
  }

  static void onTapGoAddNewTaskScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.addNewTaskScreen);
  }

  static void onTapRemoveUntil(BuildContext context, String screen) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      screen,
      (Route<dynamic> route) => false,
    );
  }

}
