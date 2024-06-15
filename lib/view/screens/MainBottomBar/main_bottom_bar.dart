import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/screens/CancelledTaskScreen/cancelled_task_screen.dart';
import 'package:task_manager/view/screens/CompleteTaskScreen/complete_task_screen.dart';
import 'package:task_manager/view/screens/InProgressTaskScreen/in_progress_task_screen.dart';
import 'package:task_manager/view/screens/NewTaskScreen/new_task_screen.dart';
import 'package:task_manager/view/widgets/custom_nav_item.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen(),
  ];

  void _switchNavPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomNavItem(
              index: 0,
              selectedIndex: _selectedIndex,
              icon: Icons.task,
              label: "New Task",
              onTap: _switchNavPage,
            ),
            CustomNavItem(
              index: 1,
              selectedIndex: _selectedIndex,
              icon: Icons.done,
              label: "Completed",
              onTap: _switchNavPage,
            ),
            CustomNavItem(
              index: 2,
              selectedIndex: _selectedIndex,
              icon: Icons.cancel_outlined,
              label: "Cancelled",
              onTap: _switchNavPage,
            ),
            CustomNavItem(
              index: 3,
              selectedIndex: _selectedIndex,
              icon: Icons.timelapse_outlined,
              label: "Progress",
              onTap: _switchNavPage,
            ),
          ],
        ),
      ),
    );
  }
}
