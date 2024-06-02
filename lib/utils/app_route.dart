import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/SplashScreen/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";

  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    Widget? widget;
    switch (settings.name) {
      case splashScreen:
        widget = SplashScreen();
        break;
    }
    if (widget != null) {
      return MaterialPageRoute(builder: (context) => widget!);
    }

    return null;
  }
}
