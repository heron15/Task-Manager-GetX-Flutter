import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final IconData icon;
  final String text;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        onTap.call(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isSelected ? AppColor.themeColor : AppColor.white,
            ),
            child: Icon(
              icon,
              size: isSelected?22:20,
              color: isSelected ? AppColor.white : AppColor.grey,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColor.themeColor : AppColor.textColorSecondary,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
