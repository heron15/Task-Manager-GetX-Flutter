import 'package:flutter/material.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/utility/on_tap_action.dart';
import 'package:task_manager/view/widgets/center_progress_indicator.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';
import '../../widgets/profile_app_bar.dart';
import 'inner/build_summary_section.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _newTaskInProgress = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: RefreshIndicator(
        color: AppColor.themeColor,
        onRefresh: () async {
          _getNewTask();
        },
        child: Visibility(
          visible: _newTaskInProgress == false,
          replacement: const CenterProgressIndicator(),
          child: ListView(
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            children: [
              buildSummarySection(),
              const SizedBox(
                height: 10,
              ),
              ...newTaskList.map(
                (task) {
                  return TaskListItem(
                    taskModel: task,
                    labelBgColor: AppColor.newTaskLabelColor,
                    onTapEdit: () {},
                    onTapDelete: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 85),
        child: FloatingActionButton(
          backgroundColor: AppColor.themeColor,
          elevation: 3,
          onPressed: () {
            OnTapAction.onTapGoAddNewTaskScreen(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.add,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }

  Future<void> _getNewTask() async {
    _newTaskInProgress = true;

    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.newTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      setCustomToast(
        response.errorMessage ?? "Get new task failed!",
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }

    _newTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
