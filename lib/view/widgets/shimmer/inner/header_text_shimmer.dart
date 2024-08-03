import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class HeaderTextShimmer extends StatelessWidget {
  const HeaderTextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 100,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
