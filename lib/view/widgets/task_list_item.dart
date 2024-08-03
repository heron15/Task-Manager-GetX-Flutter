import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_list_item_controller.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/custom_alert_dialog.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({
    super.key,
    required this.taskModel,
    required this.labelBgColor,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final Color labelBgColor;
  final VoidCallback onUpdateTask;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskListItemController>(
      init: TaskListItemController(taskModel: widget.taskModel),
      builder: (taskListItemController) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: -4,
                blurRadius: 10,
                offset: const Offset(0, 2),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              widget.taskModel.title ?? '',
              style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskModel.description ?? '',
                  style: const TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Date: ${widget.taskModel.createdDate}",
                  style: const TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                        color: widget.labelBgColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        widget.taskModel.status ?? '',
                        style: const TextStyle(
                          color: AppColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ButtonBar(
                      buttonPadding: const EdgeInsets.all(0),
                      children: [
                        PopupMenuButton<String>(
                          color: AppColor.white,
                          icon: const Icon(
                            Icons.edit,
                            color: AppColor.textColorSecondary,
                          ),
                          onSelected: (String selectedValue) {
                            taskListItemController.setDropDownValue(selectedValue);
                            _updateTaskStatus(taskListItemController, selectedValue);
                          },
                          itemBuilder: (BuildContext context) {
                            return taskListItemController.statusList.map(
                              (String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: ListTile(
                                    title: Text(
                                      value,
                                      softWrap: false,
                                    ),
                                    trailing: taskListItemController.dropDownValue == value
                                        ? const Icon(Icons.done)
                                        : null,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                        IconButton(
                          iconSize: 24,
                          onPressed: () {
                            customAlertDialog(
                              context,
                              'Are you sure you want to delete it!',
                              () {
                                Navigator.pop(context);
                              },
                              () {
                                Navigator.pop(context);
                                _deleteTask(taskListItemController);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColor.textColorSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateTaskStatus(TaskListItemController taskListItemController, String status) async {
    loadingDialog();

    final bool result = await taskListItemController.updateTaskStatus(status);

    Get.back();

    if (result) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showCustomToast(
          taskListItemController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  void _deleteTask(TaskListItemController taskListItemController) async {
    loadingDialog();

    final bool result = await taskListItemController.deleteTask();

    Get.back();

    if (result) {
      if (mounted) {
        showCustomToast(
          "Task deleted successfully.",
          Icons.check_circle_outline,
          AppColor.green,
          AppColor.white,
        ).show(context);
      }
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showCustomToast(
          taskListItemController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

}
