import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/center_progress_indicator.dart';

Future<void> loadingDialog() async {
  return showDialog(
    context: TaskManager.navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 70,
          width: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColor.white,
          ),
          child: const CenterProgressIndicator(
            indicatorSize: 30,
          ),
        ),
      );
    },
  );
}
