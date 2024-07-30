import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/otp_send_controller.dart';
import 'package:task_manager/controllers/auth/otp_verification_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/custom_pin_code_text_field.dart';
import 'package:task_manager/view/widgets/elevated_text_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';
import 'package:task_manager/view/widgets/top_header_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _pinVerificationTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();
  final OtpSendController _otpSendController = Get.find<OtpSendController>();

  late Timer _timer;
  int _start = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

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
              const SizedBox(
                height: 80,
              ),

              ///------Header text------///
              const TopHeaderText(
                header: AppStrings.pinVerification,
                subHeader: AppStrings.pinVerificationSubHeader,
              ),

              ///------Pin Verification Input Field------///
              Form(
                key: _formKey,
                child: CustomPinCodeTextField(
                  pinVerificationTextEditingController: _pinVerificationTextEditingController,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              ///------Resend otp section------///
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///------Time count text------///
                  Text(
                    "$_start s",
                    style: const TextStyle(
                      color: AppColor.themeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),

                  ///------Resend text------///
                  GetBuilder<OtpSendController>(
                    builder: (otpSendController) {
                      return InkWell(
                        onTap: _isResendEnabled ? _resendOtp : null,
                        child: Text(
                          AppStrings.resend,
                          style: TextStyle(
                            color: _isResendEnabled
                                ? AppColor.themeColor
                                : AppColor.textColorSecondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ///------Verify Button------///
              GetBuilder<OtpVerificationController>(
                builder: (otpVerificationController) {
                  return ElevatedTextButton(
                    text: AppStrings.verify,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _otpVerification();
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
                onTap: () => _onTapSignIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginScreen, (Route<dynamic> route) => false);
  }

  void _otpVerification() async {
    String otp = _pinVerificationTextEditingController.text.trim();

    loadingDialog(context);

    int resultCode = await _otpVerificationController.otpVerification(widget.email, otp);

    Get.back();

    if (resultCode == 1) {
      onTapGoResetPasswordScreen(
        widget.email,
        otp,
      );
    } else if (resultCode == 2) {
      _clearOtpField();
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.red,
          AppColor.themeColor,
          "Invalid Otp!",
          "Please enter valid otp!",
          Icons.error_outline_rounded,
          () {
            Get.back();
          },
        );
      }
    } else {
      _clearOtpField();
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.red,
          AppColor.themeColor,
          "Failed!",
          "Something went wrong!",
          Icons.task_alt,
          () {
            Get.back();
          },
        );
      }
    }
  }

  void _resendOtp() async {
    loadingDialog(context);

    int resultCode = await _otpSendController.otpSend(widget.email);

    Get.back();

    if (resultCode == 1) {
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.themeColor,
          AppColor.themeColor,
          "Resend success!",
          "Please check your email and collect otp.",
          Icons.task_alt,
          () {
            Get.back();
          },
        );
      }
    } else {
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.red,
          AppColor.themeColor,
          "Failed!",
          "Otp send failed, Resend again!",
          Icons.task_alt,
          () {
            Get.back();
          },
        );
      }
    }
    _startTimer();
  }

  void _startTimer() {
    _isResendEnabled = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendEnabled = true;
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void onTapGoResetPasswordScreen(String email, String otp) {
    Get.toNamed('${AppRoute.resetPasswordScreen}?email=$email&otp=$otp');
  }

  void _clearOtpField() {
    _pinVerificationTextEditingController.clear();
  }

  @override
  void dispose() {
    _pinVerificationTextEditingController.dispose();
    super.dispose();
  }
}
