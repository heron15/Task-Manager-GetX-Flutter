import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/reset_password_controller.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/utils/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/elevated_text_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/top_header_text.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ResetPasswordController _resetPasswordController = Get.find<ResetPasswordController>();

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
              const SizedBox(height: 30),
              const TopHeaderText(
                header: AppStrings.setNewPassword,
                subHeader: AppStrings.setNewPasswordSubHeader,
              ),

              ///------Password Text Field------///
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textEditingController: _passwordTextEditingController,
                      textInputType: TextInputType.visiblePassword,
                      titleText: AppStrings.password,
                      hintText: AppStrings.passwordHintText,
                      obscureText: true,
                      showSuffixIcon: true,
                      bottomPadding: 10,
                      validator: (value) {
                        return ValidateCheckingFun.validatePassword(value);
                      },
                    ),

                    ///------Confirm Password Text Field------///
                    CustomTextFormField(
                      textEditingController: _confirmPasswordTextEditingController,
                      textInputType: TextInputType.visiblePassword,
                      titleText: AppStrings.confirmPassword,
                      hintText: AppStrings.passwordHintText,
                      obscureText: true,
                      showSuffixIcon: true,
                      bottomPadding: 15,
                      validator: (value) {
                        return ValidateCheckingFun.validatePassword(value);
                      },
                    ),
                  ],
                ),
              ),

              ///------Confirm Button------///
              GetBuilder<ResetPasswordController>(
                builder: (resetPasswordController) {
                  return ElevatedTextButton(
                    text: AppStrings.confirm,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_passwordTextEditingController.text !=
                            _confirmPasswordTextEditingController.text) {
                          showCustomToast(
                            AppStrings.passwordNotMatch,
                            Icons.error_outline,
                            AppColor.red,
                            AppColor.white,
                          ).show(context);
                        } else {
                          _resetPassword();
                        }
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              ///------Sign in text------///
              RichTextOnTap(
                text01: AppStrings.haveAccount,
                text02: AppStrings.signIn,
                onTap: () => _onTapSignIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPassword() async {
    loadingDialog();

    final bool result = await _resetPasswordController.resetPassword(
      widget.email,
      widget.otp,
      _confirmPasswordTextEditingController.text,
    );

    Get.back();

    if (result) {
      _clearTextField();

      oneButtonDialog(
        AppColor.themeColor,
        AppColor.themeColor,
        AppStrings.success,
        AppStrings.passwordResetSuccess,
        Icons.task_alt,
        () {
          _onTapSuccess();
        },
      );
    } else {
      _clearTextField();
      oneButtonDialog(
        AppColor.red,
        AppColor.themeColor,
        AppStrings.failed,
        AppStrings.somethingWentWrong,
        Icons.task_alt,
        () {
          Navigator.pop(context);
        },
      );
    }
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginScreen, (Route<dynamic> route) => false);
  }

  void _onTapSuccess() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginScreen, (Route<dynamic> route) => false);
  }

  void _clearTextField() {
    _passwordTextEditingController.clear();
    _confirmPasswordTextEditingController.clear();
  }

  @override
  void dispose() {
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }
}
