import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/two_rich_text_custom.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      height: 80,
      width: 100,
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
      child: TwoRichTextCustom(
        firstText: count,
        secondText: "\n$title",
        firstTextColor: AppColor.textColorPrimary,
        secondTextColor: AppColor.textColorSecondary,
        firstTextSize: 24,
        secondTextSize: 14,
        firstTextFontWeight: FontWeight.w500,
        secondTextFontWeight: FontWeight.w400,
        textAlign: TextAlign.center,
        leftPadding: 5,
        rightPadding: 5,
      ),
    );
  }
}
