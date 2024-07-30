import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColor.textColorPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
