import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/dependency_injection.dart';
import 'package:task_manager/themes/app_bar.dart';
import 'package:task_manager/themes/elevated_button.dart';
import 'package:task_manager/themes/text_theme.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_color.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //status bar color change
        statusBarIconBrightness: Brightness.dark //status bar icon color change
        ));
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoute.splashScreen,
      getPages: AppRoute.route,
      initialBinding: DependencyInjection(),
      theme: ThemeData(
        primaryColor: AppColor.themeColor,
        elevatedButtonTheme: getElevatedButtonThemeData(),
        textTheme: getTextTheme(),
        appBarTheme: getAppBarTheme(),
      ),
    );
  }
}
