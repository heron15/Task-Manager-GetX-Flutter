import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/widgets/shimmer/inner/header_text_shimmer.dart';
import 'package:task_manager/view/widgets/shimmer/inner/shimmer_widget.dart';

class TaskSummaryShimmerWidget extends StatelessWidget {
  const TaskSummaryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const HeaderTextShimmer(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
                  height: 80,
                  width: 100,
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
