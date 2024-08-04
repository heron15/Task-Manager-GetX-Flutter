import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/internet_connection_controller.dart';
import 'package:task_manager/controllers/new_task_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_internet_widget.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/shimmer/task_item_shimmer_widget.dart';
import 'package:task_manager/view/widgets/shimmer/task_summary_shimmer_widget.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';
import 'package:task_manager/view/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<InternetConnectionController>(
        builder: (internetConnectionController) {
          return !internetConnectionController.connectionStatus
              ? const NoInternetWidget()
              : GetBuilder<NewTaskController>(
                  builder: (newTaskController) {
                    return RefreshIndicator(
                      color: AppColor.themeColor,
                      onRefresh: () async {
                        _getNewTask(newTaskController);
                        _getTaskCountByStatus(newTaskController);
                      },
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        children: [
                          summaryListWidget(newTaskController),
                          taskListWidget(newTaskController),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget summaryListWidget(NewTaskController newTaskController) {
    return newTaskController.taskCountByStatusInProgress
        ? const TaskSummaryShimmerWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: AppStrings.taskSummary),
              newTaskController.taskCountByStatusList.isEmpty
                  ? const NoTaskWidget(
                      height: 80,
                      text: AppStrings.noTaskSummaryAvailable,
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: newTaskController.taskCountByStatusList.map(
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

  Widget taskListWidget(NewTaskController newTaskController) {
    return newTaskController.newTaskInProgress
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: const TaskItemShimmerWidget(),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: AppStrings.newTask),
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
                                _getNewTask(newTaskController);
                                _getTaskCountByStatus(newTaskController);
                              },
                            );
                          },
                        ).toList(),
                      ),
              ],
            ),
          );
  }

  ///------Task Count By Status List Part------///
  void _getTaskCountByStatus(NewTaskController newTaskController) async {
    final bool result = await newTaskController.getTaskCountByStatus();

    if (!result) {
      showCustomToast(
        newTaskController.errorMessageTaskCountByStatusList,
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }
  }

  ///------New Task list Part------///
  void _getNewTask(NewTaskController newTaskController) async {
    final bool result = await newTaskController.getNewTask();

    if (!result) {
      if (mounted) {
        showCustomToast(
          newTaskController.errorMessageForNewTaskList,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }
}
