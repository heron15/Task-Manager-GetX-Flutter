import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/utils/asset_paths.dart';
import 'package:task_manager/view/widgets/two_rich_text_custom.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      margin: const EdgeInsets.only(bottom: 100),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPaths.noInternetLogo,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
              color: AppColor.textColorSecondary,
              colorBlendMode: BlendMode.srcIn,
            ),
            const TwoRichTextCustom(
              firstText: AppStrings.noInternetTitle,
              secondText: "\n${AppStrings.noInternetDescription}",
              firstTextColor: AppColor.textColorSecondary,
              secondTextColor: AppColor.textColorSecondary,
              firstTextSize: 18,
              secondTextSize: 14,
              firstTextFontWeight: FontWeight.w600,
              secondTextFontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              height: 1.5,
              topPadding: 15,
            ),
          ],
        ),
      ),
    );
  }
}
