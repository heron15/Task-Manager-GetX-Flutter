import 'package:task_manager/view/screens/Auth/login_screen.dart';
import 'package:task_manager/view/screens/Auth/otp_send_screen.dart';
import 'package:task_manager/view/screens/Auth/otp_verification_screen.dart';
import 'package:task_manager/view/screens/Auth/signup_screen.dart';
import 'package:task_manager/view/screens/add_new_task_screen.dart';
import 'package:task_manager/view/screens/Auth/reset_password_screen.dart';
import 'package:task_manager/view/screens/main_bottom_bar.dart';
import 'package:task_manager/view/screens/new_task_screen.dart';
import 'package:task_manager/view/screens/profile_info.dart';
import 'package:task_manager/view/screens/splash_screen.dart';
import 'package:task_manager/view/screens/update_profile_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  //splash screen
  static const String splashScreen = "/splash_screen";

  //auth part
  static const String loginScreen = "/login_screen";
  static const String otpSendScreen = "/otp_send_screen";
  static const String signupScreen = "/signup_screen";
  static const String otpVerificationScreen = "/otp_verification_screen";
  static const String resetPasswordScreen = "/reset_password_screen";

  //main part
  static const String mainBottomBar = "/main_bottom_bar";
  static const String profileInfo = "/profile_info";
  static const String updateProfileScreen = "/update_profile_screen";
  static const String addNewTaskScreen = "/add_new_task_screen";
  static const String newTaskScreen = "/new_task_screen";

  static List<GetPage> route = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: otpSendScreen, page: () => const OtpSendScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen()),
    GetPage(
      name: otpVerificationScreen,
      page: () => OtpVerificationScreen(email: Get.parameters['email'] ?? ''),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(
        email: Get.parameters['email'] ?? '',
        otp: Get.parameters['otp'] ?? '',
      ),
    ),
    GetPage(name: mainBottomBar, page: () => const MainBottomBar()),
    GetPage(name: profileInfo, page: () => const ProfileInfo()),
    GetPage(name: updateProfileScreen, page: () => const UpdateProfileScreen()),
    GetPage(name: addNewTaskScreen, page: () => const AddNewTaskScreen()),
    GetPage(name: newTaskScreen, page: () => const NewTaskScreen()),
  ];
}
