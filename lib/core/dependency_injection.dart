import 'package:get/get.dart';
import 'package:task_manager/controllers/complete_task_controller.dart';
import 'package:task_manager/controllers/internet_connection_controller.dart';
import 'package:task_manager/controllers/auth/login_controller.dart';
import 'package:task_manager/controllers/main_bottom_bar_controller.dart';
import 'package:task_manager/controllers/new_task_controller.dart';
import 'package:task_manager/controllers/auth/otp_send_controller.dart';
import 'package:task_manager/controllers/auth/otp_verification_controller.dart';
import 'package:task_manager/controllers/auth/reset_password_controller.dart';
import 'package:task_manager/controllers/auth/signup_controller.dart';
import 'package:task_manager/controllers/auth/user_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => OtpSendController(), fenix: true);
    Get.lazyPut(() => OtpVerificationController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => InternetConnectionController(), fenix: true);
    Get.lazyPut(() => MainBottomBarController(), fenix: true);
    Get.lazyPut(() => NewTaskController(), fenix: true);
    Get.lazyPut(() => CompleteTaskController(), fenix: true);
  }
}
