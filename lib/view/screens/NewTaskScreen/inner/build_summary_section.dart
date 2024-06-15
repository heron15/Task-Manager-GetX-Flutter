import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/NewTaskScreen/inner/task_summary_card.dart';

Widget buildSummarySection() {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        TaskSummaryCard(
          count: '12',
          title: 'Canceled',
        ),
        TaskSummaryCard(
          count: '12',
          title: 'Completed',
        ),
        TaskSummaryCard(
          count: '12',
          title: 'Progress',
        ),
        TaskSummaryCard(
          count: '12',
          title: 'New Task',
        ),
      ],
    ),
  );
}
