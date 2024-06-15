import 'package:flutter/material.dart';
import 'package:task_manager/view/widgets/background_widget.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_route.dart';
import '../../../utility/on_tap_action.dart';
import '../../../utility/validate_checking_fun.dart';
import '../../../widgets/bottom_rich_text.dart';
import '../../../widgets/custom_toast.dart';
import '../../../widgets/elevated_text_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText01 = true;
  bool _obscureText02 = true;

  void _toggleObscureText01() {
    setState(() {
      _obscureText01 = !_obscureText01;
    });
  }

  void _toggleObscureText02() {
    setState(() {
      _obscureText02 = !_obscureText02;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///------Header Text------///
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                ///------Sub Header Text------///
                Text(
                  "Minimum length password 8 character with latter, symbol and number.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),

                      ///------Password Text Field------///
                      TextFormField(
                        controller: _passwordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: AppColor.themeColor,
                        obscureText: _obscureText01,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: _toggleObscureText01,
                            icon: Icon(
                              _obscureText01 ? Icons.visibility : Icons.visibility_off,
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          return ValidateCheckingFun.validatePassword(value);
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ///------Confirm Password Text Field------///
                      TextFormField(
                        controller: _confirmPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: AppColor.themeColor,
                        obscureText: _obscureText02,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                            onPressed: _toggleObscureText02,
                            icon: Icon(
                              _obscureText02 ? Icons.visibility : Icons.visibility_off,
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          return ValidateCheckingFun.validatePassword(value);
                        },
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      ///------Confirm Button------///
                      ElevatedTextButton(
                        text: "Confirm",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordTextEditingController.text !=
                                _confirmPasswordTextEditingController.text) {
                              setCustomToast(
                                "Password not match! Enter same password.",
                                Icons.error_outline,
                                AppColor.red,
                                AppColor.white,
                              ).show(context);
                            } else {
                              OnTapAction.onTapRemoveUntil(context, AppRoute.loginScreen);
                            }
                          }
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      ///------Sign in text------///
                      Center(
                        child: BottomRichText(
                          text01: "Have account?",
                          text02: "Sign In",
                          onTap: () => OnTapAction.onTapRemoveUntil(context, AppRoute.loginScreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
