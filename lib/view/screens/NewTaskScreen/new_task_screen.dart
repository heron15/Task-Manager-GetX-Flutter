import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/utility/on_tap_action.dart';
import 'package:task_manager/view/widgets/task_list_item.dart';
import '../../widgets/profile_app_bar.dart';
import 'inner/build_summary_section.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildSummarySection(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return TaskListItem(
                          title: "Task title here",
                          subTitle: "Hello, here is sub title need to add.",
                          date: "22/08/2024",
                          labelText: "New",
                          labelBgColor: AppColor.newTaskLabelColor,
                          onTapEdit: () {},
                          onTapDelete: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 85),
        child: FloatingActionButton(
          backgroundColor: AppColor.themeColor,
          elevation: 3,
          onPressed: () {
            OnTapAction.onTapGoAddNewTaskScreen(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.add,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
