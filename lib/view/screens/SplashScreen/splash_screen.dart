import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/utils/app_route.dart';
import 'package:task_manager/utils/asset_paths.dart';
import 'package:task_manager/view/controllers/auth_controller.dart';
import 'package:task_manager/view/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isUserLoggedIn = await AuthController.checkAuthState();
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
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.transAppLogo,
            height: 220,
            width: 220,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
