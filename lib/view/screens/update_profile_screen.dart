import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/update_profile_controller.dart';
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
  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();

  @override
  void initState() {
    super.initState();
    final userData = AuthSharedPreferencesController.userData!;
    _emailTextEditingController.text = userData.email ?? '';
    _firstNameTextEditingController.text = userData.firstName ?? '';
    _lastNameTextEditingController.text = userData.lastName ?? '';
    _mobileTextEditingController.text = userData.mobile ?? '';
    _updateProfileController.setProfileImage(userData.photo ?? '');
  }

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
        child: GetBuilder<UpdateProfileController>(
          builder: (updateProfileController) {
            return SingleChildScrollView(
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
                        imageString: updateProfileController.profileImage,
                        imageWidth: 100,
                        imageHeight: 100,
                        imageRadius: 50,
                        borderColor: AppColor.textColorPrimary,
                      ),
                      InkWell(
                        onTap: () {
                          updateProfileController.pickImage();
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
                          textInputType: TextInputType.phone,
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
            );
          },
        ),
      ),
    );
  }

  void _updateProfile() async {
    loadingDialog();

    final bool result = await _updateProfileController.updateProfile(
      _emailTextEditingController.text.trim(),
      _firstNameTextEditingController.text.trim(),
      _lastNameTextEditingController.text.trim(),
      _mobileTextEditingController.text.trim(),
      _passwordTextEditingController.text,
    );

    Get.back();

    if (result) {
      oneButtonDialog(
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
    } else {
      if (mounted) {
        showCustomToast(
          _updateProfileController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _mobileTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
