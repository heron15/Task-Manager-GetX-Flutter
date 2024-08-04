import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/cancelled_task_controller.dart';
import 'package:task_manager/controllers/internet_connection_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_internet_widget.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/shimmer/task_item_shimmer_widget.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<InternetConnectionController>(
        builder: (internetConnectionController) {
          return !internetConnectionController.connectionStatus
              ? const NoInternetWidget()
              : GetBuilder<CancelledTaskController>(
                  builder: (cancelledTaskController) {
                    return RefreshIndicator(
                      color: AppColor.themeColor,
                      onRefresh: () async {
                        _getCancelledTask(cancelledTaskController);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: cancelledTaskController.canceledTaskInProgress
                            ? const TaskItemShimmerWidget()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionHeader(title: "Canceled Task"),
                                  cancelledTaskController.canceledTaskList.isEmpty
                                      ? const Expanded(
                                          child: NoTaskWidget(
                                            height: double.maxFinite,
                                            text: AppStrings.noTaskAvailable,
                                          ),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                cancelledTaskController.canceledTaskList.length,
                                            itemBuilder: (context, index) {
                                              return TaskListItem(
                                                taskModel:
                                                    cancelledTaskController.canceledTaskList[index],
                                                labelBgColor: AppColor.cancelledLabelColor,
                                                onUpdateTask: () {
                                                  _getCancelledTask(cancelledTaskController);
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

  void _getCancelledTask(CancelledTaskController cancelledTaskController) async {
    final bool result = await cancelledTaskController.getCancelledTask();

    if (!result) {
      if (mounted) {
        showCustomToast(
          cancelledTaskController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }
}
