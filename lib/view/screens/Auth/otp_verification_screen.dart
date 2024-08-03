import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/auth/otp_send_controller.dart';
import 'package:task_manager/controllers/auth/otp_verification_controller.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/core/app_route.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/view/widgets/custom_toast.dart';
import 'package:task_manager/view/widgets/rich_text_on_tap.dart';
import 'package:task_manager/view/widgets/custom_pin_code_text_field.dart';
import 'package:task_manager/view/widgets/elevated_text_button.dart';
import 'package:task_manager/view/widgets/loading_dialog.dart';
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

  final OtpSendController _otpSendController = Get.find<OtpSendController>();
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: GetBuilder<OtpVerificationController>(
          builder: (otpVerificationController) {
            return SingleChildScrollView(
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
                        "${otpVerificationController.start} s",
                        style: const TextStyle(
                          color: AppColor.themeColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),

                      ///------Resend text------///
                      InkWell(
                        onTap: otpVerificationController.isResendEnabled ? _resendOtp : null,
                        child: Text(
                          AppStrings.resend,
                          style: TextStyle(
                            color: otpVerificationController.isResendEnabled
                                ? AppColor.themeColor
                                : AppColor.textColorSecondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ///------Verify Button------///
                  ElevatedTextButton(
                    text: AppStrings.verify,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _otpVerification(otpVerificationController);
                      }
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
            );
          },
        ),
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginScreen, (Route<dynamic> route) => false);
  }

  void _otpVerification(OtpVerificationController otpVerificationController) async {
    String otp = _pinVerificationTextEditingController.text.trim();

    loadingDialog();

    int resultCode = await otpVerificationController.otpVerification(widget.email, otp);

    Get.back();

    if (resultCode == 1) {
      onTapGoResetPasswordScreen(
        widget.email,
        otp,
      );
    } else if (resultCode == 2) {
      _clearOtpField();
      if (mounted) {
        showCustomToast(
          resultCode == 2 ? AppStrings.validOtpEnter : AppStrings.somethingWentWrong,
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }

  void _resendOtp() async {
    loadingDialog();

    int resultCode = await _otpSendController.otpSend(widget.email);

    Get.back();

    if (mounted) {
      showCustomToast(
        resultCode == 1 ? AppStrings.resendSuccess : AppStrings.otpSendFailed,
        resultCode == 1 ? Icons.check_circle_outline : Icons.error_outline,
        resultCode == 1 ? AppColor.green : AppColor.red,
        AppColor.white,
      ).show(context);
    }

    _otpVerificationController.startTimer();
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
