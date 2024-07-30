import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({
    super.key,
    required this.height,
    required this.text,
  });

  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.textColorSecondary,
        ),
      ),
    );
  }
}
