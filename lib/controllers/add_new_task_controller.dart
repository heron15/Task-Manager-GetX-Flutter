import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class AddNewTaskController extends GetxController {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(title, description) async {
    bool isSuccess = false;

    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postResponse(
      ApiUrl.createTask,
      body: requestData,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.addNewTaskFailed;
      isSuccess = false;
    }

    return isSuccess;
  }
}
