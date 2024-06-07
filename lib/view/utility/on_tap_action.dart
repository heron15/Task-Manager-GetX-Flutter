import 'package:flutter/cupertino.dart';

import '../../utils/app_route.dart';

class OnTapAction {
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

  static void onTapRemoveUntil(BuildContext context, String screen) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      screen,
      (Route<dynamic> route) => false,
    );
  }
}
