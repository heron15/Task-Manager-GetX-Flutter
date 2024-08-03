import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:task_manager/utils/app_color.dart';

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({super.key, this.indicatorSize = 40});

  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        size: indicatorSize,
        color: AppColor.themeColor,
      ),
    );
  }
}
