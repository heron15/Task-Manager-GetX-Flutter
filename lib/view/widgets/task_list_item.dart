import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';

import '../../utils/app_color.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.taskModel,
    required this.labelBgColor,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  final TaskModel taskModel;
  final Color labelBgColor;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          taskModel.title ?? '',
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
              taskModel.description ?? '',
              style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Text(
              "Date: ${taskModel.createdDate}",
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                  decoration: BoxDecoration(
                    color: labelBgColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    taskModel.status ?? '',
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
                    IconButton(
                      iconSize: 24,
                      onPressed: onTapEdit,
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      iconSize: 24,
                      onPressed: onTapDelete,
                      icon: const Icon(
                        Icons.delete,
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
}
