import 'package:flutter/material.dart';
import 'package:task_manager/view/widgets/background_widget.dart';
import 'package:task_manager/view/widgets/elevated_text_button.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_route.dart';
import '../../../utility/on_tap_action.dart';
import '../../../utility/validate_checking_fun.dart';
import '../../../widgets/bottom_rich_text.dart';
import '../../../widgets/elevated_icon_button.dart';

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
                    "Join With Us",
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

                        ///------First Name Text Field------///
                        TextFormField(
                          controller: _firstNameTextEditingController,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColor.themeColor,
                          decoration: const InputDecoration(
                            hintText: "First Name",
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateFirstName(value);
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ///------Last Name Text Field------///
                        TextFormField(
                          controller: _lastNameTextEditingController,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColor.themeColor,
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateLastName(value);
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ///------Mobile Text Field------///
                        TextFormField(
                          controller: _mobileTextEditingController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColor.themeColor,
                          decoration: const InputDecoration(
                            hintText: "Mobile",
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateNumber(value);
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

                        ///------Sign Up Button------///
                        ElevatedIconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              oneButtonDialog(
                                context,
                                AppColor.themeColor,
                                "Success!",
                                "Now login your account.",
                                Icons.task_alt,
                                (){
                                  OnTapAction.onTapRemoveUntil(context, AppRoute.loginScreen);
                                },
                              );
                            }
                          },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        ///------Sign In Text------///
                        Center(
                          child: BottomRichText(
                            text01: "Have account?",
                            text02: "Sign In",
                            onTap: () => Navigator.pop(context),
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
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _mobileTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
