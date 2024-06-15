import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/utility/on_tap_action.dart';
import 'package:task_manager/view/widgets/background_widget.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/view/utility/validate_checking_fun.dart';

import '../../../widgets/bottom_rich_text.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  const SizedBox(
                    height: 80,
                  ),

                  ///------Header text------///
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  ///------Sub Header Text------///
                  Text(
                    "A 6 digit verification pin will send to your email address.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  ///------Email Text Field------///
                  Form(
                    key: _formKey,
                    child: TextFormField(
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
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  ///------Button------///
                  ElevatedIconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        OnTapAction.onTapGoPinVerificationScreen(context);
                      }
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  ///------Sign in text------///
                  Center(
                    child: BottomRichText(
                      text01: "Have account?",
                      text02: "Sign In",
                      onTap: () => Navigator.pop(context),
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
    super.dispose();
  }
}
