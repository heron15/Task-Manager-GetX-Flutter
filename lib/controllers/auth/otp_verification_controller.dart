import 'dart:async';

import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class OtpVerificationController extends GetxController {
  String _errorMessage = '';
  late Timer _timer;
  int _start = 60;
  bool _isResendEnabled = false;

  String get errorMessage => _errorMessage;

  int get start => _start;

  bool get isResendEnabled => _isResendEnabled;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<int> otpVerification(String email, String otp) async {
    int isSuccess = 0;

    final NetworkResponse response = await NetworkCaller.getResponse(
      "${ApiUrl.recoverVerifyOTP}/$email/$otp",
    );

    if (response.isSuccess) {
      if (response.responseData['status'] == 'success') {
        isSuccess = 1;
      } else if (response.responseData['data'] == 'Invalid OTP Code') {
        isSuccess = 2;
      }
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.otpSendFailed;
      isSuccess = 0;
    }

    return isSuccess;
  }

  void startTimer() {
    _isResendEnabled = false;
    _start = 60;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_start == 0) {
          _isResendEnabled = true;
          update();
          _timer.cancel();
        } else {
          _start--;
          update();
        }
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
