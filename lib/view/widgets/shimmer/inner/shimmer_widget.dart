import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager/utils/app_color.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.simmerBgColor,
      highlightColor: AppColor.simmerItemColor,
      child: child,
    );
  }
}
