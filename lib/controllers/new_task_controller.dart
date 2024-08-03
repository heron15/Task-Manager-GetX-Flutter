import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_count_by_status_model.dart';
import 'package:task_manager/data/model/task_count_by_status_wrapper_model.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class NewTaskController extends GetxController {
  bool _taskCountByStatusInProgress = false;
  bool _newTaskInProgress = false;
  List<TaskCountByStatusModel> _taskCountByStatusList = [];
  List<TaskModel> _newTaskList = [];
  String _errorMessageTaskCountByStatusList = '';
  String _errorMessageForNewTaskList = '';

  bool get taskCountByStatusInProgress => _taskCountByStatusInProgress;

  bool get newTaskInProgress => _newTaskInProgress;

  List<TaskCountByStatusModel> get taskCountByStatusList => _taskCountByStatusList;

  List<TaskModel> get newTaskList => _newTaskList;

  String get errorMessageTaskCountByStatusList => _errorMessageTaskCountByStatusList;

  String get errorMessageForNewTaskList => _errorMessageForNewTaskList;

  @override
  void onInit() {
    super.onInit();
    getTaskCountByStatus();
    getNewTask();
  }

  ///------Task Count By Status List Part------///
  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;

    _taskCountByStatusInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.taskStatusCount);

    if (response.isSuccess) {
      isSuccess = true;
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStatusList = taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      isSuccess = false;
      _errorMessageTaskCountByStatusList = response.errorMessage ?? AppStrings.somethingWentWrong;
    }

    _taskCountByStatusInProgress = false;
    update();

    return isSuccess;
  }

  ///------New Task list Part------///
  Future<bool> getNewTask() async {
    bool isSuccess = false;

    _newTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.newTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      isSuccess = false;
      _errorMessageForNewTaskList = response.errorMessage ?? AppStrings.somethingWentWrong;
    }

    _newTaskInProgress = false;
    update();

    return isSuccess;
  }
}
