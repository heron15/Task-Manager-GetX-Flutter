import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.generateRoute,
      theme: ThemeData(),
    );
  }
}
