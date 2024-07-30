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

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _cancelledTaskInProgress = false;
  List<TaskModel> cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: RefreshIndicator(
        color: AppColor.themeColor,
        onRefresh: () async {
          _getCancelledTask();
        },
        child: _cancelledTaskInProgress
            ? const CenterProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: "Canceled Task"),
                    cancelledTaskList.isEmpty
                        ? const Expanded(
                            child: NoTaskWidget(
                              height: double.maxFinite,
                              text: AppStrings.noTaskAvailable,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: cancelledTaskList.length,
                              itemBuilder: (context, index) {
                                return TaskListItem(
                                  taskModel: cancelledTaskList[index],
                                  labelBgColor: AppColor.cancelledLabelColor,
                                  onUpdateTask: () {
                                    _getCancelledTask();
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

  Future<void> _getCancelledTask() async {
    setState(() {
      _cancelledTaskInProgress = true;
    });

    NetworkResponse response = await NetworkCaller.getResponse(ApiUrl.canceledTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      cancelledTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      setCustomToast(
        response.errorMessage ?? "Get cancelled task failed!",
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }

    _cancelledTaskInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }
}
