import 'package:flutter/material.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
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
  bool _deleteInProgress = false;
  bool _editTaskStatusInProgress = false;

  String dropDownValue = '';

  List<String> statusList = [
    'New',
    'Progress',
    'Completed',
    'Canceled',
  ];

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
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
                        dropDownValue = selectedValue;
                        if (mounted) {
                          setState(() {});
                        }
                        _updateTaskStatus(selectedValue);
                      },
                      itemBuilder: (BuildContext context) {
                        return statusList.map(
                          (String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: ListTile(
                                title: Text(
                                  value,
                                  softWrap: false,
                                ),
                                trailing: dropDownValue == value ? const Icon(Icons.done) : null,
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
                            _deleteTask();
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
  }

  Future<void> _updateTaskStatus(String status) async {
    _editTaskStatusInProgress = true;

    if (mounted) {
      setState(() {});
    }

    loadingDialog();

    NetworkResponse response = await NetworkCaller.getResponse(
      ApiUrl.updateTaskStatus(widget.taskModel.sId!, status),
    );

    _editTaskStatusInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (mounted) {
      Navigator.pop(context);
    }

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      showCustomToast(
        response.errorMessage ?? "Task status update failed!",
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true;

    if (mounted) {
      setState(() {});
    }

    loadingDialog();

    NetworkResponse response =
        await NetworkCaller.getResponse(ApiUrl.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      showCustomToast(
        response.errorMessage ?? "Task delete failed!",
        Icons.error_outline,
        AppColor.red,
        AppColor.white,
      );
    }

    _deleteInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
