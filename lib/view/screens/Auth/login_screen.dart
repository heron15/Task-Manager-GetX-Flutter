import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/login_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/utils/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/top_header_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isCheckValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///------Header Text------///
              const TopHeaderText(
                header: AppStrings.signIn,
                subHeader: AppStrings.signInSubHeader,
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

                    ///------Password Text Field------///
                    CustomTextFormField(
                      textEditingController: _passwordTextEditingController,
                      textInputType: TextInputType.visiblePassword,
                      titleText: AppStrings.password,
                      hintText: AppStrings.passwordHintText,
                      showSuffixIcon: true,
                      obscureText: true,
                      validator: (value) {
                        return ValidateCheckingFun.validatePassword(value);
                      },
                    ),
                  ],
                ),
              ),

              ///------Remember me section------///
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isCheckValue,
                    activeColor: AppColor.themeColor,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckValue = value!;
                      });
                    },
                  ),
                  const Text(
                    AppStrings.rememberMe,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              ///------Login Button------///
              GetBuilder<LoginController>(
                builder: (loginController) {
                  return ElevatedIconButton(
                    icon: Icons.arrow_circle_right_outlined,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _userLogin(loginController);
                      }
                    },
                  );
                },
              ),

              const SizedBox(
                height: 30,
              ),

              ///------Forgot password part------///
              TextButton(
                onPressed: () => _onTapGoForgotPasswordScreen(),
                child: const Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    color: AppColor.textColorSecondary,
                    fontSize: 14,
                  ),
                ),
              ),

              ///------Sign Up Text------///
              RichTextOnTap(
                text01: AppStrings.dontHaveAnAccount,
                text02: AppStrings.signUp,
                onTap: () => _onTapGoSignUpScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapGoForgotPasswordScreen() {
    Navigator.pushNamed(context, AppRoute.otpSendScreen);
  }

  void _onTapGoSignUpScreen() {
    Navigator.pushNamed(context, AppRoute.signupScreen);
  }

  void _userLogin(LoginController loginController) async {
    loadingDialog();

    final bool result = await loginController.signIn(
      _emailTextEditingController.text.trim(),
      _passwordTextEditingController.text,
      _isCheckValue,
    );

    Get.back();

    if (result) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoute.mainBottomBar);
      }
    } else {
      _clearTextField();
      if (mounted) {
        showCustomToast(
          loginController.errorMessage,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  void _clearTextField() {
    _emailTextEditingController.clear();
    _passwordTextEditingController.clear();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
