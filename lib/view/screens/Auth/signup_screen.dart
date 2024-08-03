import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/signup_controller.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/utils/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/top_header_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _mobileTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignupController _signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///------Header Text------///

              const TopHeaderText(
                header: AppStrings.createAccount,
                subHeader: AppStrings.signUpSubHeader,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///------Email Text Field------///
                    CustomTextFormField(
                      textEditingController: _emailTextEditingController,
                      textInputType: TextInputType.emailAddress,
                      titleText: AppStrings.email,
                      hintText: AppStrings.emailHintText,
                      bottomPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateEmail(value);
                      },
                    ),

                    ///------First Name Text Field------///
                    CustomTextFormField(
                      textEditingController: _firstNameTextEditingController,
                      textInputType: TextInputType.name,
                      titleText: AppStrings.fistName,
                      hintText: AppStrings.firstNameHintText,
                      bottomPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateFirstName(value);
                      },
                    ),

                    ///------Last Name Text Field------///
                    CustomTextFormField(
                      textEditingController: _lastNameTextEditingController,
                      textInputType: TextInputType.name,
                      titleText: AppStrings.lastName,
                      hintText: AppStrings.lastNameHintText,
                      bottomPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateLastName(value);
                      },
                    ),

                    ///------Mobile Text Field------///
                    CustomTextFormField(
                      textEditingController: _mobileTextEditingController,
                      textInputType: TextInputType.number,
                      titleText: AppStrings.mobile,
                      hintText: AppStrings.mobileHintText,
                      bottomPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validateNumber(value);
                      },
                    ),

                    ///------Password Text Field------///
                    CustomTextFormField(
                      textEditingController: _passwordTextEditingController,
                      textInputType: TextInputType.visiblePassword,
                      titleText: AppStrings.password,
                      hintText: AppStrings.passwordHintText,
                      showSuffixIcon: true,
                      bottomPadding: 10,
                      obscureText: true,
                      validator: (value) {
                        return ValidateCheckingFun.validatePassword(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              ///------Sign Up Button------///
              GetBuilder<SignupController>(
                builder: (signupController) {
                  return ElevatedIconButton(
                    icon: Icons.arrow_circle_right_outlined,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registerUser();
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              ///------Sign In Text------///
              RichTextOnTap(
                text01: AppStrings.haveAccount,
                text02: AppStrings.signIn,
                onTap: () => Navigator.pop(context),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    loadingDialog();

    final bool result = await _signupController.signUp(
      _emailTextEditingController.text.trim(),
      _firstNameTextEditingController.text.trim(),
      _lastNameTextEditingController.text.trim(),
      _mobileTextEditingController.text.trim(),
      _passwordTextEditingController.text,
    );

    Get.back();

    if (result) {
      _clearTextField();

      oneButtonDialog(
        AppColor.themeColor,
        AppColor.themeColor,
        AppStrings.success,
        AppStrings.registrationSuccess,
        Icons.task_alt,
        () {
          _onTapSignUpSuccess();
        },
      );
    } else {
      oneButtonDialog(
        AppColor.red,
        AppColor.themeColor,
        AppStrings.failed,
        AppStrings.registrationFailed,
        Icons.task_alt,
        () {
          Get.back();
        },
      );
    }
  }

  void _onTapSignUpSuccess() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginScreen, (Route<dynamic> route) => false);
  }

  void _clearTextField() {
    _emailTextEditingController.clear();
    _firstNameTextEditingController.clear();
    _lastNameTextEditingController.clear();
    _mobileTextEditingController.clear();
    _passwordTextEditingController.clear();
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
