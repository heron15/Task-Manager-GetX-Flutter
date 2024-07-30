import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controllers/auth/user_controller.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/utils/api_url.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/controllers/auth_shared_preferences_controller.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/utils/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/custom_circle_avatar.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/elevated_text_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _mobileTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final userData = AuthSharedPreferencesController.userData!;
    _emailTextEditingController.text = userData.email ?? '';
    _firstNameTextEditingController.text = userData.firstName ?? '';
    _lastNameTextEditingController.text = userData.lastName ?? '';
    _mobileTextEditingController.text = userData.mobile ?? '';
    _profileImage = AuthSharedPreferencesController.userData?.photo ?? '';
  }

  bool _updateProfileInProgress = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  String _profileImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text(
          AppStrings.updateProfile,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///------Profile picture show and Photo picker widget------///
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomCircleAvatar(
                    imageString: _profileImage,
                    imageWidth: 100,
                    imageHeight: 100,
                    imageRadius: 50,
                    borderColor: AppColor.textColorPrimary,
                  ),
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: AppColor.themeColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: AppColor.white,
                      ),
                    ),
                  )
                ],
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///------Email text form field------///
                    CustomTextFormField(
                      textEditingController: _emailTextEditingController,
                      textInputType: TextInputType.emailAddress,
                      titleText: AppStrings.email,
                      hintText: AppStrings.emailHintText,
                      topPadding: 20,
                      enabled: false,
                      validator: (value) {
                        return ValidateCheckingFun.validateEmail(value);
                      },
                    ),

                    ///------First text form field------///
                    CustomTextFormField(
                      textEditingController: _firstNameTextEditingController,
                      textInputType: TextInputType.name,
                      titleText: AppStrings.fistName,
                      hintText: AppStrings.firstNameHintText,
                      topPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateFirstName(value);
                      },
                    ),

                    ///------Last name text form field------///
                    CustomTextFormField(
                      textEditingController: _lastNameTextEditingController,
                      textInputType: TextInputType.name,
                      titleText: AppStrings.lastName,
                      hintText: AppStrings.lastNameHintText,
                      topPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateLastName(value);
                      },
                    ),

                    ///------Mobile text form field------///
                    CustomTextFormField(
                      textEditingController: _mobileTextEditingController,
                      textInputType: TextInputType.name,
                      titleText: AppStrings.mobile,
                      hintText: AppStrings.mobileHintText,
                      topPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateNumber(value);
                      },
                    ),
                  ],
                ),
              ),

              ///------Password text form field------///
              CustomTextFormField(
                textEditingController: _passwordTextEditingController,
                textInputType: TextInputType.visiblePassword,
                titleText: AppStrings.password,
                hintText: AppStrings.passwordOptional,
                topPadding: 10,
                bottomPadding: 20,
                obscureText: true,
                showSuffixIcon: true,
                validator: (value) {
                  return ValidateCheckingFun.validatePassword(value);
                },
              ),

              ///------Update button------///
              ElevatedTextButton(
                text: "Update",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfile();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;

    String encodePhoto = AuthSharedPreferencesController.userData?.photo ?? '';

    if (mounted) {
      setState(() {});
    }

    loadingDialog(context);

    Map<String, dynamic> requestBody = {
      "email": _emailTextEditingController.text.trim(),
      "firstName": _firstNameTextEditingController.text.trim(),
      "lastName": _lastNameTextEditingController.text.trim(),
      "mobile": _mobileTextEditingController.text.trim(),
    };

    if (_passwordTextEditingController.text.isNotEmpty) {
      requestBody["password"] = _passwordTextEditingController.text;
    }

    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestBody["photo"] = encodePhoto;
    }

    final NetworkResponse response =
        await NetworkCaller.postResponse(ApiUrl.profileUpdate, body: requestBody);

    _updateProfileInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (mounted) {
      Navigator.pop(context);
    }

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
        email: _emailTextEditingController.text.trim(),
        photo: encodePhoto,
        firstName: _firstNameTextEditingController.text.trim(),
        lastName: _lastNameTextEditingController.text.trim(),
        mobile: _mobileTextEditingController.text.trim(),
      );
      await AuthSharedPreferencesController.saveUserData(userModel);
      Get.find<UserController>().setUser(userModel);
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.themeColor,
          AppColor.themeColor,
          "Update Success!",
          "Your profile information update successfully.",
          Icons.task_alt,
          () {
            Get.back();
            Get.back();
          },
        );
      }
    } else {
      if (mounted) {
        setCustomToast(
          response.errorMessage ?? "Update failed!",
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        );
      }
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
        _profileImage = base64Encode(File(pickedFile.path).readAsBytesSync());
      });
    }
  }
}
