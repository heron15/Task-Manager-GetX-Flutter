import 'package:get/get.dart';

class MainBottomBarController extends GetxController {
  var _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void switchNavPage(int index) {
    _selectedIndex = index;
    update();
  }
}
