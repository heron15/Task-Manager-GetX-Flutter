import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class CancelledTaskController extends GetxController {
  bool _canceledTaskInProgress = false;
  List<TaskModel> _canceledTaskList = [];
  String _errorMessage = '';

  bool get canceledTaskInProgress => _canceledTaskInProgress;

  List get canceledTaskList => _canceledTaskList;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getCancelledTask();
  }

  Future<bool> getCancelledTask() async {
    bool isSuccess = false;

    _canceledTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.canceledTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _canceledTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? AppStrings.somethingWentWrong;
      isSuccess = false;
    }

    _canceledTaskInProgress = false;
    update();

    return isSuccess;
  }
}
