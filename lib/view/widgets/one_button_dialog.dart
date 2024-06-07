import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import 'elevated_text_button.dart';

Future<dynamic> oneButtonDialog(
  BuildContext context,
  Color themeColor,
  String header,
  String subHeader,
  IconData icon,
  VoidCallback onPressed,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColor.white,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: themeColor,
                size: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                header,
                style: const TextStyle(
                  color: AppColor.themeColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subHeader,
                style: const TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedTextButton(
                text: "Ok",
                onPressed: onPressed,
                width: 70,
                borderRadius: 25,
                backgroundColor: themeColor,
              ),
            ],
          ),
        ),
      );
    },
  );
}
