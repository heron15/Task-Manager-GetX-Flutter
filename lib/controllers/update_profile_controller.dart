import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controllers/auth/user_controller.dart';
import 'package:task_manager/controllers/auth_shared_preferences_controller.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_strings.dart';

class UpdateProfileController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  String _profileImage = '';
  String _errorMessage = "";

  XFile? get selectedImage => _selectedImage;

  String get profileImage => _profileImage;

  void setProfileImage(String profileImage) {
    _profileImage = profileImage;
    update();
  }

  String get errorMessage => _errorMessage;

  ///------Update profile controller function------///
  Future<bool> updateProfile(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (_selectedImage != null) {
      requestBody["photo"] = _profileImage;
    }

    if (password.isNotEmpty) {
      requestBody["password"] = password;
    }

    try {
      final NetworkResponse response = await NetworkCaller.postResponse(
        ApiUrl.profileUpdate,
        body: requestBody,
      );

      if (response.isSuccess) {
        UserModel userModel = UserModel(
          photo: _profileImage,
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
        );

        await AuthSharedPreferencesController.saveUserData(userModel);
        Get.find<UserController>().setUser(userModel);

        isSuccess = true;
      } else {
        _errorMessage = response.errorMessage ?? AppStrings.profileUpdateError;
        isSuccess = false;
      }
    } catch (e) {
      _errorMessage = "Failed to update profile: $e";
      isSuccess = false;
    }

    return isSuccess;
  }

  ///------Pick image function------///
  Future<void> pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = pickedFile;
      await _encodeImage(pickedFile);
    }
  }

  Future<void> _encodeImage(XFile image) async {
    final bytes = await File(image.path).readAsBytes();
    _profileImage = base64Encode(bytes);
    update();
  }
}
