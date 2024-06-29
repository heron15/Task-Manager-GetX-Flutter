import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.themeColor,
      ),
    );
  }
}
