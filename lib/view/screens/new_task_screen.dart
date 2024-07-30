import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/new_task_controller.dart';
import 'package:task_manager/data/model/task_count_by_status_model.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/center_progress_indicator.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';
import 'package:task_manager/view/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<NewTaskController>(
        builder: (newTaskController) {
          return newTaskController.taskCountByStatusInProgress &&
                  newTaskController.newTaskInProgress
              ? const CenterProgressIndicator()
              : RefreshIndicator(
                  color: AppColor.themeColor,
                  onRefresh: () async {
                    _getNewTask();
                    _getTaskCountByStatus();
                  },
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    children: [
                      summarySectionWidget(newTaskController.taskCountByStatusList),
                      const SizedBox(height: 10),
                      const SectionHeader(
                        title: AppStrings.newTask,
                      ),
                      newTaskController.newTaskList.isEmpty
                          ? const NoTaskWidget(
                              height: 400,
                              text: AppStrings.noTaskAvailable,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: newTaskController.newTaskList.map(
                                (task) {
                                  return TaskListItem(
                                    taskModel: task,
                                    labelBgColor: AppColor.newTaskLabelColor,
                                    onUpdateTask: () {
                                      _getNewTask();
                                      _getTaskCountByStatus();
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                      const SizedBox(height: 90),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget summarySectionWidget(List<TaskCountByStatusModel> taskCountByStatusModelList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: AppStrings.taskSummary,
        ),
        taskCountByStatusModelList.isEmpty
            ? const NoTaskWidget(
                height: 80,
                text: AppStrings.noTaskSummaryAvailable,
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: taskCountByStatusModelList.map(
                    (e) {
                      return TaskSummaryCard(
                        count: e.sum.toString(),
                        title: e.sId ?? 'Unknown',
                      );
                    },
                  ).toList(),
                ),
              ),
      ],
    );
  }

  ///------Task Count By Status List Part------///
  void _getTaskCountByStatus() async {
    final bool result = await _newTaskController.getTaskCountByStatus();

    if (!result) {
      setCustomToast(
        _newTaskController.errorMessageTaskCountByStatusList,
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }
  }

  ///------New Task list Part------///
  void _getNewTask() async {
    final bool result = await _newTaskController.getNewTask();

    if (!result) {
      setCustomToast(
        _newTaskController.errorMessageForNewTaskList,
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }
  }
}
