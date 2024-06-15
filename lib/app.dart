import 'package:flutter/material.dart';
import 'package:task_manager/themes/app_bar.dart';
import 'package:task_manager/themes/elevated_button.dart';
import 'package:task_manager/themes/input_decoration.dart';
import 'package:task_manager/themes/text_theme.dart';
import 'package:task_manager/utils/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.generateRoute,
      theme: ThemeData(
        inputDecorationTheme: getInputDecorationTheme(),
        elevatedButtonTheme: getElevatedButtonThemeData(),
        textTheme: getTextTheme(),
        appBarTheme: getAppBarTheme(),
      ),
    );
  }
}
