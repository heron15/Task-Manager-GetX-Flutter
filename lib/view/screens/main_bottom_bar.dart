import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth_shared_preferences_controller.dart';
import 'package:task_manager/controllers/main_bottom_bar_controller.dart';
import 'package:task_manager/controllers/auth/user_controller.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/screens/cancelled_task_screen.dart';
import 'package:task_manager/view/screens/complete_task_screen.dart';
import 'package:task_manager/view/screens/in_progress_task_screen.dart';
import 'package:task_manager/view/screens/new_task_screen.dart';
import 'package:task_manager/view/widgets/custom_circle_avatar.dart';
import 'package:task_manager/view/widgets/nav_item.dart';
import 'package:task_manager/view/widgets/two_rich_text_custom.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomBarController>(
      builder: (mainBottomBarController) {
        return Scaffold(
          backgroundColor: AppColor.themeColor,
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                ///------App bar part------///
                appBar(context),

                ///------Main body part------///
                Expanded(
                  child: _screens[mainBottomBarController.selectedIndex],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Stack(
            alignment: Alignment.topCenter,
            children: [
              otherNavItemWidget(mainBottomBarController),
              middleNavItemWidget(),
            ],
          ),
        );
      },
    );
  }

  ///------App bar section------///
  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: _onTapProfileInfo,
            child: GetBuilder<UserController>(
              builder: (userController) {
                final user = userController.user.value;
                return Row(
                  children: [
                    CustomCircleAvatar(
                      imageString: user.photo ?? '',
                      imageWidth: 50,
                      imageHeight: 50,
                      imageRadius: 25,
                      borderColor: AppColor.white,
                    ),
                    TwoRichTextCustom(
                      firstText: user.fullName,
                      secondText: "\n${user.email ?? ''}",
                      firstTextColor: AppColor.white,
                      secondTextColor: AppColor.white.withOpacity(0.9),
                      firstTextSize: 16,
                      secondTextSize: 14,
                      firstTextFontWeight: FontWeight.w600,
                      secondTextFontWeight: FontWeight.w500,
                      leftPadding: 15,
                      height: 1.3,
                    ),
                  ],
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              AuthSharedPreferencesController.clearAllData();
              _onTapLogout();
            },
            icon: const Icon(
              Icons.logout,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  ///------Four navbar item------///
  Widget otherNavItemWidget(MainBottomBarController mainBottomBarController) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.textColorPrimary.withAlpha(100),
            spreadRadius: 1,
            blurRadius: 9,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItem(
            index: 0,
            selectedIndex: mainBottomBarController.selectedIndex,
            icon: Icons.task,
            onTap: mainBottomBarController.switchNavPage,
            text: 'New Task',
          ),
          NavItem(
            index: 1,
            selectedIndex: mainBottomBarController.selectedIndex,
            icon: Icons.check_circle_outline,
            onTap: mainBottomBarController.switchNavPage,
            text: 'Complete',
          ),
          const SizedBox(width: 40),
          NavItem(
            index: 2,
            selectedIndex: mainBottomBarController.selectedIndex,
            icon: Icons.cancel_outlined,
            onTap: mainBottomBarController.switchNavPage,
            text: 'Canceled',
          ),
          NavItem(
            index: 3,
            selectedIndex: mainBottomBarController.selectedIndex,
            icon: Icons.timelapse_outlined,
            onTap: mainBottomBarController.switchNavPage,
            text: 'In Progress',
          ),
        ],
      ),
    );
  }

  ///------Middle nav item widget------///
  Widget middleNavItemWidget() {
    return Container(
      width: 75,
      height: 75,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColor.textColorPrimary.withAlpha(100),
            spreadRadius: -9,
            blurRadius: 9,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          onTapGoAddNewTaskScreen(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColor.themeColor,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }

  static void onTapGoAddNewTaskScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.addNewTaskScreen);
  }

  void _onTapLogout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginScreen,
      (Route<dynamic> route) => false,
    );
  }

  void _onTapProfileInfo() {
    Navigator.pushNamed(context, AppRoute.profileInfo);
  }
}
