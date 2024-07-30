import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/complete_task_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/center_progress_indicator.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/no_task_widget.dart';
import 'package:task_manager/view/widgets/section_header.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  final CompleteTaskController _completeTaskController = Get.find<CompleteTaskController>();

  @override
  void initState() {
    super.initState();
    _getCompleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<CompleteTaskController>(
        builder: (completeTaskController) {
          return RefreshIndicator(
            color: AppColor.themeColor,
            onRefresh: () async {
              _getCompleteTask();
            },
            child: completeTaskController.completeTaskInProgress
                ? const CenterProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(title: "Complete Task"),
                        completeTaskController.completeTaskList.isEmpty
                            ? const Expanded(
                                child: NoTaskWidget(
                                  height: double.maxFinite,
                                  text: AppStrings.noTaskAvailable,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: completeTaskController.completeTaskList.length,
                                  itemBuilder: (context, index) {
                                    return TaskListItem(
                                      taskModel: completeTaskController.completeTaskList[index],
                                      labelBgColor: AppColor.completeLabelColor,
                                      onUpdateTask: () {
                                        _getCompleteTask();
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
      ),
    );
  }

  void _getCompleteTask() async {
    final bool result = await _completeTaskController.getCompleteTask();

    if (!result) {
      setCustomToast(
        _completeTaskController.errorMessage,
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }
  }
}
