import 'package:flutter/material.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/center_progress_indicator.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _progressTaskInProgress = false;
  List<TaskModel> progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: RefreshIndicator(
        color: AppColor.themeColor,
        onRefresh: () async {
          _getProgressTask();
        },
        child: _progressTaskInProgress
            ? const CenterProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: "In Progress Task"),
                    progressTaskList.isEmpty
                        ? const Expanded(
                            child: NoTaskWidget(
                              height: double.maxFinite,
                              text: AppStrings.noTaskAvailable,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: progressTaskList.length,
                              itemBuilder: (context, index) {
                                return TaskListItem(
                                  taskModel: progressTaskList[index],
                                  labelBgColor: AppColor.progressLabelColor,
                                  onUpdateTask: () {
                                    _getProgressTask();
                                  },
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _getProgressTask() async {
    setState(() {
      _progressTaskInProgress = true;
    });

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.progressTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      progressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      setCustomToast(
        response.errorMessage ?? "Get progress task failed!",
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }

    setState(() {
      _progressTaskInProgress = false;
    });
  }
}
