import 'package:flutter/material.dart';
import 'package:task_manager/view/utility/on_tap_action.dart';

import '../../utils/app_color.dart';
import 'network_cached_image.dart';

AppBar profileAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          OnTapAction.onTapGoUpdateProfileScreen(context);
        },
        child: const CircleAvatar(
          backgroundColor: AppColor.white,
          child: NetworkCachedImage(
            url: '',
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: (){
        OnTapAction.onTapGoUpdateProfileScreen(context);
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dummy Name',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'email@gmail.com',
            style: TextStyle(
              fontSize: 12,
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}
