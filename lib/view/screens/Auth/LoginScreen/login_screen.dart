import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/utility/on_tap_action.dart';
import 'package:task_manager/view/widgets/background_widget.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/view/utility/validate_checking_fun.dart';

import '../../../widgets/bottom_rich_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

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
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),

                        ///------Email Text Field------///
                        TextFormField(
                          controller: _emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColor.themeColor,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateEmail(value);
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ///------Password Text Field------///
                        TextFormField(
                          controller: _passwordTextEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColor.themeColor,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
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

                        ///------Login Button------///
                        ElevatedIconButton(
                          icon: Icons.arrow_circle_right_outlined,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              OnTapAction.onTapGoMainBottomBar(context);
                            }
                          },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///------Forget Password Text------///
                              TextButton(
                                onPressed: () => OnTapAction.onTapGoForgotPasswordScreen(context),
                                child: const Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    color: AppColor.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              ///------Sign Up Text------///
                              BottomRichText(
                                text01: "Don't have an account?",
                                text02: "Sign Up",
                                onTap: () => OnTapAction.onTapGoSignUpScreen(context),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
