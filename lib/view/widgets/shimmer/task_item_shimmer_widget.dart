import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/shimmer/inner/header_text_shimmer.dart';
import 'package:task_manager/view/widgets/shimmer/inner/shimmer_widget.dart';

class TaskItemShimmerWidget extends StatelessWidget {
  const TaskItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderTextShimmer(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  width: double.maxFinite,
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
