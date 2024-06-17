import 'package:flutter/material.dart';
import 'package:task_manager/view/widgets/profile_app_bar.dart';

import '../../../utils/app_color.dart';
import '../../widgets/task_list_item.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return TaskListItem(
                title: "Task title here",
                subTitle: "Hello, here is sub title need to add.",
                date: "22/08/2024",
                labelText: "Cancelled",
                labelBgColor: AppColor.cancelledLabelColor,
                onTapEdit: () {},
                onTapDelete: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
