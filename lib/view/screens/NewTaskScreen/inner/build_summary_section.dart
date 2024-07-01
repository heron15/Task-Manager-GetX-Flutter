import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_count_by_status_model.dart';
import 'package:task_manager/view/screens/NewTaskScreen/inner/task_summary_card.dart';

Widget buildSummarySection(List<TaskCountByStatusModel> taskCountByStatusModelList) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: taskCountByStatusModelList.map((e) {
        return TaskSummaryCard(
          count: e.sum.toString(),
          title: e.sId ?? 'Unknown',
        );
      }).toList(),
    ),
  );
}
