import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class ElevatedTextButton extends StatelessWidget {
  const ElevatedTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
