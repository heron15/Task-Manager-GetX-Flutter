import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/app_color.dart';
import '../../utils/validate_checking_fun.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({
    super.key,
    required this.pinVerificationTextEditingController,
  });

  final TextEditingController pinVerificationTextEditingController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: AppColor.white,
        inactiveFillColor: AppColor.white,
        selectedColor: AppColor.themeColor,
        inactiveColor: Colors.grey,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: pinVerificationTextEditingController,
      keyboardType: TextInputType.number,
      appContext: context,
      validator: (String? value) {
        return ValidateCheckingFun.validatePinVerification(value);
      },
    );
  }
}
