import 'package:flutter/material.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/asset_paths.dart';
import 'package:task_manager/controllers/auth_shared_preferences_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isUserLoggedIn = await AuthSharedPreferencesController.checkAuthState();
    if (mounted) {
      Navigator.pushReplacementNamed(
          context, isUserLoggedIn ? AppRoute.mainBottomBar : AppRoute.loginScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.themeColor,
      body: Center(
        child: Image.asset(
          AssetPaths.appLogoTran,
          height: 220,
          width: 220,
          fit: BoxFit.cover,
          color: AppColor.white,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}
