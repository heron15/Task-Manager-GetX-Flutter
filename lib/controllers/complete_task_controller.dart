import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class CompleteTaskController extends GetxController {
  bool _completeTaskInProgress = false;
  List<TaskModel> _completeTaskList = [];
  String _errorMessage = '';

  bool get completeTaskInProgress => _completeTaskInProgress;

  List get completeTaskList => _completeTaskList;

  String get errorMessage => _errorMessage;

  Future<bool> getCompleteTask() async {
    bool isSuccess = false;

    _completeTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.completeTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _completeTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage ?? AppStrings.somethingWentWrong;
    }

    _completeTaskInProgress = false;
    update();

    return isSuccess;
  }
}
