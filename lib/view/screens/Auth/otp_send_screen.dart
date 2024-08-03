import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/otp_send_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_text_form_field.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/utils/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/top_header_text.dart';

class OtpSendScreen extends StatefulWidget {
  const OtpSendScreen({super.key});

  @override
  State<OtpSendScreen> createState() => _OtpSendScreenState();
}

class _OtpSendScreenState extends State<OtpSendScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              ///------Header text------///
              const SizedBox(height: 30),
              const TopHeaderText(
                header: AppStrings.yourEmailAddress,
                subHeader: AppStrings.a6DigitVerification,
              ),

              ///------Email Text Field------///
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  textEditingController: _emailTextEditingController,
                  textInputType: TextInputType.emailAddress,
                  titleText: AppStrings.email,
                  hintText: AppStrings.emailHintText,
                  bottomPadding: 15,
                  validator: (value) {
                    return ValidateCheckingFun.validateEmail(value);
                  },
                ),
              ),

              ///------Button------///
              GetBuilder<OtpSendController>(
                builder: (otpSendController) {
                  return ElevatedIconButton(
                    icon: Icons.arrow_circle_right_outlined,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendOtp(otpSendController);
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 40),

              ///------Sign in text------///
              RichTextOnTap(
                text01: AppStrings.haveAccount,
                text02: AppStrings.signIn,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendOtp(OtpSendController otpSendController) async {
    String email = _emailTextEditingController.text.trim();

    loadingDialog();

    int resultCode = await otpSendController.otpSend(email);

    Get.back();

    if (resultCode == 1) {
      onTapGoPinVerificationScreen(email);
    } else if (resultCode == 2) {
      _clearTextField();
      if (mounted) {
        showCustomToast(
          AppStrings.emailNotRegister,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    } else {
      _clearTextField();
      if (mounted) {
        showCustomToast(
          AppStrings.somethingWentWrong,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  void onTapGoPinVerificationScreen(String email) {
    Get.toNamed(
      '${AppRoute.otpVerificationScreen}?email=$email',
    );
  }

  void _clearTextField() {
    _emailTextEditingController.clear();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }
}
