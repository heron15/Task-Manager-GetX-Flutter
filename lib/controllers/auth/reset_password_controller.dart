import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class ResetPasswordController extends GetxController {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> resetPassword(String email, String otp, String password) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.recoverResetPass,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.resetPasswordErrorMessage;
      isSuccess = false;
    }

    return isSuccess;
  }
}
