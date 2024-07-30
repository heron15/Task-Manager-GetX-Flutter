import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

TextTheme getTextTheme() => const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColor.textColorPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: AppColor.textColorSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
