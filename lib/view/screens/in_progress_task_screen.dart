import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/in_progress_task_controller.dart';
import 'package:task_manager/controllers/internet_connection_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_internet_widget.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/shimmer/task_item_shimmer_widget.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<InternetConnectionController>(
        builder: (internetConnectionController) {
          return !internetConnectionController.connectionStatus
              ? const NoInternetWidget()
              : GetBuilder<InProgressTaskController>(
                  builder: (inProgressTaskController) {
                    return RefreshIndicator(
                      color: AppColor.themeColor,
                      onRefresh: () async {
                        _getInProgressTask(inProgressTaskController);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: inProgressTaskController.inProgressTaskInProgress
                            ? const TaskItemShimmerWidget()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionHeader(title: "In Progress Task"),
                                  inProgressTaskController.inProgressTaskList.isEmpty
                                      ? const Expanded(
                                          child: NoTaskWidget(
                                            height: double.maxFinite,
                                            text: AppStrings.noTaskAvailable,
                                          ),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                inProgressTaskController.inProgressTaskList.length,
                                            itemBuilder: (context, index) {
                                              return TaskListItem(
                                                taskModel: inProgressTaskController
                                                    .inProgressTaskList[index],
                                                labelBgColor: AppColor.progressLabelColor,
                                                onUpdateTask: () {
                                                  _getInProgressTask(inProgressTaskController);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  void _getInProgressTask(InProgressTaskController inProgressTaskController) async {
    final bool result = await inProgressTaskController.getInProgressTask();

    if (!result) {
      if (mounted) {
        showCustomToast(
          inProgressTaskController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }
}
