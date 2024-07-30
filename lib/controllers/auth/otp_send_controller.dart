import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class OtpSendController extends GetxController {
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<int> otpSend(String email) async {
    int isSuccess = 0;

    final NetworkResponse response = await NetworkCaller.getResponse(
      "${ApiUrl.recoverVerifyEmail}/$email",
    );

    if (response.isSuccess) {
      if (response.responseData['status'] == 'success') {
        isSuccess = 1;
      } else if (response.responseData['data'] == 'No User Found') {
        isSuccess = 2;
      }
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.otpSendFailed;
      isSuccess = 0;
    }

    return isSuccess;
  }
}
